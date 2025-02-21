//
//  DebugAccountsPropertiesView.swift
//  Lunar
//
//  Created by Mani on 30/07/2023.
//

import Foundation
import SwiftUI

struct DebugAccountsPropertiesView: View {
  @AppStorage("loggedInUsersList") var loggedInUsersList = Settings.loggedInUsersList
  @AppStorage("debugModeEnabled") var debugModeEnabled = Settings.debugModeEnabled
  @AppStorage("selectedActorID") var selectedActorID = Settings.selectedActorID
  @AppStorage("loggedInEmailsList") var loggedInEmailsList = Settings.loggedInEmailsList
  @AppStorage("appBundleID") var appBundleID = Settings.appBundleID
  @AppStorage("loggedInAccounts") var loggedInAccounts = Settings.loggedInAccounts

  var showingPopover: Bool
  var isPresentingConfirm: Bool
  var logoutAllUsersButtonClicked: Bool
  var logoutAllUsersButtonOpacity: Double
  var isLoadingDeleteButton: Bool
  var deleteConfirmationShown: Bool

  var keychainDebugString: String {
    KeychainHelper.standard.generateDebugString(
      service: "io.github.mani-sh-reddy.Lunar.app"
    )
  }

  var body: some View {
    Section {
      VStack(alignment: .leading, spacing: 5) {
        Text("Debug Properties").bold().textCase(.uppercase)
        Group {
          HStack {
            Text("showingPopover").bold()
            Text("\(String(showingPopover))")
              .booleanColor(bool: showingPopover)
          }
          HStack {
            Text("isPresentingConfirm").bold()
            Text("\(String(isPresentingConfirm))")
              .booleanColor(bool: isPresentingConfirm)
          }
          HStack {
            Text("logoutAllUsersButtonClicked").bold()
            Text("\(String(logoutAllUsersButtonClicked))")
              .booleanColor(bool: logoutAllUsersButtonClicked)
          }
          HStack {
            Text("logoutAllUsersButtonClicked").bold()
            Text("\(String(logoutAllUsersButtonClicked))")
              .booleanColor(bool: logoutAllUsersButtonClicked)
          }
          HStack {
            Text("logoutAllUsersButtonOpacity").bold()
            Text("\(String(logoutAllUsersButtonOpacity))")
          }
          HStack {
            Text("isLoadingDeleteButton").bold()
            Text("\(String(isLoadingDeleteButton))")
              .booleanColor(bool: isLoadingDeleteButton)
          }
          HStack {
            Text("deleteConfirmationShown").bold()
            Text("\(String(deleteConfirmationShown))")
              .booleanColor(bool: deleteConfirmationShown)
          }
        }
        VStack(alignment: .leading) {
          VStack(alignment: .leading) {
            Text("@AppStorage selectedActorID:").bold()
            Text("\(selectedActorID)")
          }.padding(.vertical, 10)
          VStack(alignment: .leading) {
            Text("@AppStorage loggedInUsersList:").bold()
            Text("\(loggedInUsersList.rawValue)")
          }.padding(.vertical, 10)
          VStack(alignment: .leading) {
            Text("@AppStorage loggedInEmailsList:").bold()
            Text("\(loggedInEmailsList.rawValue)")
          }.padding(.vertical, 10)
          VStack(alignment: .leading) {
            Text("@AppStorage loggedInAccounts:").bold()
            Text("\(loggedInAccounts.rawValue)")
          }.padding(.vertical, 10)
        }
        VStack(alignment: .leading) {
          Text("KEYCHAIN").bold()
          Text("\(keychainDebugString)")
        }.padding(.vertical, 10)
      }
    }
    .font(.caption)
    .if(!debugModeEnabled) { _ in EmptyView() }
  }
}
