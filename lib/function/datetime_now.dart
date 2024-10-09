String dateTimeNowCode() =>
    DateTime.now().toLocal().toString().replaceAll('-', '').replaceAll(':', '').replaceAll('.', '').replaceAll(' ', '');
