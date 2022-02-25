//
//  LocalizedString.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 10/18/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import Foundation

/// Centralized Location of all Localizeable Strings as written in Swift to be easily shared across targets and tests.
/// LocalizedString is defined as an enum to prevent instantiation
enum LocalizedString {
    
    // MARK: - ServerListViewController
    
    static let serverUpdateBegin = NSLocalizedString("Cargando servidores...", comment: "Notify the user that the server update has started.")
    static let serverUpdateSuccess = NSLocalizedString("Servidores cargados con éxito!", comment: "Notify the user that the server update has succeeded.")
    static let serverUpdateFailed = NSLocalizedString("Error de actualización del servidor", comment: "Notify the user that the server update has failed.")
    
    // MARK: - General
    static let loading = NSLocalizedString("Cargando...", comment: "Label shown for loading to indicate indeterminate progress")
    static let bestAvailable = NSLocalizedString("Mejor Servidor Disponible", comment: "Cell allowing the user to let the app choose the optimal city, country for the connection")
    
    // MARK: - Dashboard
    static let aes256 = NSLocalizedString("AES-256", comment: "Label indicating the current encryption level of the connection")
    static let aes128 = NSLocalizedString("AES-128", comment: "Label indicating the current encryption level of the connection")
    static let bestAvailableLocation = NSLocalizedString("Mejor Servidor Disponible", comment: "Button that allows the user to simply let the app choose the optimal server")
    static let statusConnected = NSLocalizedString("Conectado", comment: "Status label to indicate to the user that they are connected to the VPN.")
    
    // MARK: - Empty State View
    static let somethingWentWrongTitle = NSLocalizedString("Algo estuvo mal", comment: "Title telling the user something went wrong") // Also used as Alert Title
    static let noResultsFound = NSLocalizedString("No Se Encontraron Resultados", comment: "Title Label shown to indicate no servers match provided options and/or search text")
    static let noResultsReloadServers = NSLocalizedString("Ningun servidor fue encontrado. Intenta nuevamente.", comment: "Label shown to indicate no servers were found at all and prompt the user to attempt to retry loading the servers again")
    
    static let noMatchInPingRangeFormat = NSLocalizedString("No se encontraron servidores que coincidan con \"%@\" en el rango ping \"%@\".",
                                                            comment: "Label shown for no servers matching search text within ping range")
    static let noMatchFormat = NSLocalizedString("No se encontraron servidores que coincidan con \"%@\".",
                                                 comment: "Label shown for no servers matching search text")
    static let noResultsInPingRangeFormat = NSLocalizedString("No se encontraron servidores en el rango ping \"%@\". Intenta cambiando las opciones de filtrado.",
                                                              comment: "Label shown for no servers within ping range. Suggesting to change filter options")
    
    // MARK: - Filter View Controller
    // MARK: Table Headers
    static let sortByHeader = NSLocalizedString("Ordenar Por", comment: "Header presenting list of options for how to sort the servers list")
    static let pingHeader = NSLocalizedString("Ping", comment: "Header presenting list of options for constraining servers within a range of ping values")
    
    // MARK: Filter Options
    static let any = NSLocalizedString("Cualquiera", comment: "Label displaying an option indicating any and all values will be displayed")
    static let lessThanFifty = NSLocalizedString("< 50", comment: "Label displaying an option indicating only servers with a latency of less than 50 will be displayed")
    static let betweenFiftyAndOneHundred = NSLocalizedString("50 - 100", comment: "Label displaying an option indicating only servers with a latency between 50 and 100 inclusive will be displayed")
    static let betweenOneHundredAndTwoHundred = NSLocalizedString("100 - 200", comment: "Label displaying an option indicating only servers with a latency between 100 and 200 inclusive will be displayed")
    static let greaterThanTwoHundred = NSLocalizedString("> 200", comment: "Label displaying an option indicating only servers with a latency greater than 200 will be displayed")
    
    // MARK: Sort Options
    static let citySelection = NSLocalizedString("Ciudad", comment: "Label displaying a preference for sorting the servers list")
    static let countrySelection = NSLocalizedString("País", comment: "Label displaying a preference for sorting the servers list")
    static let serverCountSelection = NSLocalizedString("Server Count", comment: "Label displaying a preference for sorting the servers list")
    
    // MARK: - Settings View Controller
    
    /// Function for creating a localized formatted string asking the user to rate the current product
    ///
    /// - Parameter product: The name of the product we want the user to rate
    /// - Returns: Localized formatted string of **Rate %@**
    static func rate(productName product: String) -> String {
        return String.localizedStringWithFormat(NSLocalizedString("Califica a %@", comment: "Static Text informing the user they can rate the product"), product)
    }
    
    // MARK: - Alerts
    // MARK: Titles
    static let networkSettingsAlertTitle = NSLocalizedString("Configuración de Red", comment: "Alert Title indicating a root cause of an issue")
    static let logoutAlertTitle = NSLocalizedString("Cerrar Sesión", comment: "")
    static let loginErrorAlertTitle = NSLocalizedString("Inicio de Sesión Erroneo", comment: "A Login Error has occurred")
    static let preferencesHeader = NSLocalizedString("Preferencias", comment: "")
    static let onDemandConnectedAlertTitle = NSLocalizedString("OnDemand está habilitado", comment: "OnDemand is Enabled.")
    static let signUpErrorAlertTitle = NSLocalizedString("Error de Registro", comment: "Alert Title indicating an error on Sign Up")
    static let passwordAlertTitle = NSLocalizedString("Verificación de la cuenta", comment: "Alert title indicating more information needed to verify account")
    static let accountAlertTitle = NSLocalizedString("Cuenta Creada Satisfactoriamente", comment: "Account was created successfully.")
    
    
    // MARK: Messages
    static let logoutAlertMessageConnected = NSLocalizedString("Cerrar sesión te desconectará de la VPN. ¿Estás seguro de que te gustaría cerrar sesión?", comment: "")
    static let logoutAlertMessageDisconnected = NSLocalizedString("¿Estás seguro de que te gustaría cerrar sesión?", comment: "")
    static let loginEmptyField = NSLocalizedString("Uno o más campos de inicio de sesión están vacíos. Por favor ingrese sus credenciales.", comment: "One or more fields are empty")
    static let applyChangeReconnect = NSLocalizedString("Para aplicar este cambio ahora, debemos reiniciar su conexión. ¿Quieres continuar?", comment: "")
    static let connectingProgress = NSLocalizedString("Conectando...", comment: "")
    static let connectionFailed = NSLocalizedString("Error al conectarse al VPN", comment: "The connection to the VPN has failed.")
    static let initialServerListBegin = NSLocalizedString("Cargando Servidores Iniciales", comment: "Initial server list load has started.")
    static let networkConnectionIssue = NSLocalizedString("Parece que no hay conexión de red. Por favor revisa tu configuración de conexión.",
                                                          comment: "Alert Message requesting the user check their network settings")
    static let onDemandConnectedAlertMessage = NSLocalizedString("Disconnecting from the VPN will disable OnDemand settings. Do you wish to continue?",
                                                                 comment: "Desconectarse de la VPN deshabilitará la configuración de OnDemand. Desea continuar?")
    static let signUpEmptyFieldAlertMessage = NSLocalizedString("One or more login fields are empty. Please enter your credentials.",
                                                                comment: "Alert Message telling the user one or more fields are empty and should not be")
    static let signUpUsernameCharacterCountAlertMessage = NSLocalizedString("Tu nombre de usuario debe tener menos de 255 caracteres.",
                                                                            comment: "Alert message telling the user the email field has too many characters")
    static let signUpEmailCharacterCountAlertMessage = NSLocalizedString("Tu email debe tener menos de 100 caracteres.",
                                                                         comment: "Alert Message telling the user the email field has too many characters")
    static let signUpPasswordCharacterCountAlertMessage = NSLocalizedString("La contraseña debe tener al menos 4 caracteres.",
                                                                            comment: "Alert Message telling the user the password field has too few characters")
    static let signUpUsernameIncorrectFormatAlertMessage = NSLocalizedString("El nombre de usuario que ingresaste no es válido. Sólo se permiten letras y números. No se permiten caracteres especiales.",
                                                                             comment: "Alert message telling the user an invalid username was provided")
    static let signUpEmailIncorrectFormatAlertMessage = NSLocalizedString("El email que introduciste no es válido.",
                                                                          comment: "Alert Message telling the user an invalid email address was provided")
    static let signUpPasswordMismatchAlertMessage = NSLocalizedString("Las contraseñas no coinciden. Por favor, asegurate de que las dos son iguales.",
                                                                      comment: "Alert Message telling the user the password fields do not match")
    static let touchIDReason = NSLocalizedString("Iniciar Sesión con Touch  ID", comment: "System Alert Message to indicate reason for Touch ID prompt")
    static let passwordAlertInitialMessage = NSLocalizedString("Introduzca su contraseña:", comment: "Alert message asking user to input their account password")
    static let checkUsernameDidFailAlertMessage = NSLocalizedString("El nombre de usuario escogido ya esta en uso.", comment: "Alert message letting the user know that the username they selected is already being used.")
    private static let passwordAlertAttemptedFormat = NSLocalizedString("El intento anterior falló. Te quedan %d intento(s) antes de cerrar la sesión. Ingresa tu contraseña:", comment: "Alert message asking user to input their account password correctly")
    static func passwordAlertAttemptedMessage(withNumberOfAttempts numberOfAttempts: UInt) -> String {
        return String.localizedStringWithFormat(passwordAlertAttemptedFormat, numberOfAttempts)
    }
    
    /// Function for creating a localized formatted string based on the incoming error parameter.
    /// The string states the operation couldn't be completed due to the error and displays the error to the user.
    /// It also suggests to contact support should the problem persist.
    ///
    /// - parameter error: The reason for failure
    ///
    /// - returns: Localized formatted string of **Operation failed with error: "%@" If this problem continues, please contact support for further assistance.**
    static func contactSupport(with error: Error) -> String {
        return String.localizedStringWithFormat(NSLocalizedString("Operación con error: \"%@\" .Si el problema persiste por favor contáctenos.",
                                                                  comment: "Alert Message telling the user we don't immediately know what the problem is and to contact support"), error.localizedDescription)
    }
    
    // MARK: Actions
    static let ok = NSLocalizedString("OK", comment: "Understood")
    static let contact = NSLocalizedString("Contacto", comment: "Alert Button verb contact support")
    static let cancel = NSLocalizedString("Cancelar", comment: "")
    static let disconnect = NSLocalizedString("Desconectar y Aplicar", comment: "")
    static let reconnect = NSLocalizedString("Aplicar y Reconectar", comment: "")
    static let logout = NSLocalizedString("Salir", comment: "")
    static let onDemandConnectedAlertConfirm = NSLocalizedString("Confirm", comment: "Confirm")
    
    // MARK: - Login/Sign-Up
    static let username = NSLocalizedString("Usuario", comment: "account username")
    static let password = NSLocalizedString("Contraseña", comment: "account password")
    static let signUpPassword = NSLocalizedString("Introduzca su contraseña", comment: "account password")
    static let signUpReenterPassword = NSLocalizedString("Introduzca nuevamente su contraseña", comment: "account password")
    static let signUpUsername = NSLocalizedString("Nombre de Usuario", comment: "Placeholder text to indicate the account username should be entered")
    static let signUpEmail = NSLocalizedString("Email", comment: "Placeholder text to indicate the account email should be entered")
    static let signUp = NSLocalizedString("Crear Cuenta", comment: "")
    static let backToLogin = NSLocalizedString("Ya tienes cuenta? Inicia Sesión", comment: "")
    static let loggingInProgress = NSLocalizedString("Autenticando...", comment: "Static text indicating progress of logging in.")
    static let creatingAccountProgress = NSLocalizedString("Creando cuenta...", comment: "Static text indicating progress of logging in.")
    static let accountCreated = NSLocalizedString("Tu cuenta fue exitosamente creada", comment: "Account was created successfully.")
    static let accountNotProvisionedTitle = NSLocalizedString("Ya casi terminamos...", comment: "Title for account not provisioned alert.")
    static let accountNotProvisioned = NSLocalizedString("Su cuenta aún no ha sido completamente provisionada. Por favor, espere unos minutos antes de intentar iniciar sesión.", comment: "Account needs to be provisioned.")
    
    //MARK: - Framework Notifications
    // TODO: Move the below strings into the framework to handle
    /*
     * "AccountExpiredMessage" = "Your account is expired. Please update your information, or contact support. You may still attempt to connect.";
     * "VPNConnectionFailedInvalidConfig" = "Invalid VPN Configuration";
     * "VPNConnectionFailedInvalidProtocol" = "Invalid protocol selected";
     * "VPNConnectionFailedNoInternet" = "No Internet Connection. Please check your network settings.";
     *
     */
    /// Localized String of **Your account is expired. Please update your information, or contact support. 
    /// You may still attempt to connect.**
    static let accountExpired = NSLocalizedString("AccountExpiredMessage", comment: "Alert user that their account is expired and they should update their information or contact support to proceed.")
    /// Localized String of **Invalid VPN Configuration**
    static let invalidVPNConfig = NSLocalizedString("VPNConnectionFailedInvalidConfig", comment: "Invalid VPN Configuration")
    /// Localized String of **Invalid protocol selected**
    static let invalidProtocol = NSLocalizedString("VPNConnectionFailedInvalidProtocol", comment: "Invalid Protocol selected")
    /// Localized String of **No Internet Connection. Please check your network settings.**
    static let noInternetWarning = NSLocalizedString("VPNConnectionFailedNoInternet", comment: "Notify the user that there is an issue with their network connectivity.")
    
    
}
