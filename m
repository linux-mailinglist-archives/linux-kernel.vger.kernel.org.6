Return-Path: <linux-kernel+bounces-252023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE10930D24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B8C28132E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939C157A42;
	Mon, 15 Jul 2024 04:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PewmsV6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CDB28FC;
	Mon, 15 Jul 2024 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721016918; cv=none; b=LtqNlDeCbW+dN5DiyFDZ61K0/1sewyA53CI/PGkwECQGf5pJ+50Se/I56vYIIpMUoVPABkr4/b9LYGteX3rahQrptiau5BRcRQoZlqXNdVAmzRpmDpoBaCtonumdEYy7BfTkMGHIuJ+Z4SQ5PC4hgRplOHyHufmAnUUoeh2jbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721016918; c=relaxed/simple;
	bh=ksQXCMUdrfVGuqSjqyX7As4dlkLuKTTFWWt+Fb7liEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FPAQ68YjSkWWNJHajptLn7XOclRwMBYIs/Zu+dCq/vlcsxgycvTmM0Ro38QRJUufENjR9CWlgHxhjNR2xTZKZ/OgBrun4OeoVK5MJzu3GsWzg4l/OPnK+N2PdrxLfNDgcPEgcfSseZmkBVDLGQDexAJpT5bRxUJMBIZESY8pnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PewmsV6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31F9C4AF0B;
	Mon, 15 Jul 2024 04:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721016917;
	bh=ksQXCMUdrfVGuqSjqyX7As4dlkLuKTTFWWt+Fb7liEk=;
	h=Date:From:To:Cc:Subject:From;
	b=PewmsV6wwc5bjECkXpYP9GIMvA1sOhqcAXYnJQbgCYKfsMyxxsMQhV/s/JqfIvxcL
	 RbtSMaBFLrIOdcmPO652BWxNPAK5H7IpTYnBd0X19dxc5uAYIncwgORvQxZtG9neva
	 pOKFCc+YpxThGKol4kzKYO3Ciu3rjA3y2HGM854ljljbBUPwA/ZawUjnl9hAM5N5+k
	 Sq5f6ecqH0lvpY6ZL0hS1Kwu0Y+WTdSRFBtsbdcy5kYZGDxEipFOr7vWdQjs319/cK
	 qjonTaaz0fReHJaw+hWvvQXNB/mcFBXlKqn48YEwj8BofYalXFDKO9mNwywNiuzeWe
	 BL6PCpy653U7g==
Date: Mon, 15 Jul 2024 12:15:13 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v6.11
Message-ID: <ZpSiUTZBAOgDYYNQ@tzungbi-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6zfrOryeugXFBGg"
Content-Disposition: inline


--d6zfrOryeugXFBGg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull chrome-platform changes for v6.11.  Note that you would see a
trivial conflict in the MAINTAINERS file and you should keep both changes.
See also [1].

[1]: https://lore.kernel.org/linux-next/20240702145819.3bd4e113@canb.auug.o=
rg.au/

Thanks,
TzungBi
------

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v6.11

for you to fetch changes up to 4baf1cc54433ff7c6e5178517bc8768001416681:

  power: supply: cros_charge-control: Fix signedness bug in charge_behaviou=
r_store() (2024-07-05 01:51:33 +0000)

----------------------------------------------------------------
chrome platform changes for 6.11

* New

  - Add "cros_ec_hwmon" driver to expose fan speed and temperature.

  - Add "cros_charge-control" driver to control charge thresholds and
    behaviour.

  - Add module parameter "log_poll_period_ms" in cros_ec_debugfs for
    tuning the poll period.

  - Support version 3 of EC_CMD_GET_NEXT_EVENT and keyboard matrix.

* Fixes

  - Fix a race condition in accessing MEC (Microchip EC) memory between
    ACPI and kernel.  Serialize the memory access by an AML (ACPI
    Machine Language) mutex.

  - Fix an issue of wrong EC message version in cros_ec_debugfs.

* Misc

  - Fix kernel-doc errors and cleanups.

----------------------------------------------------------------
Ben Walsh (6):
      platform/chrome: cros_ec_lpc: MEC access can return error code
      platform/chrome: cros_ec_lpc: MEC access can use an AML mutex
      platform/chrome: cros_ec_lpc: Add a new quirk for ACPI id
      platform/chrome: cros_ec_lpc: Add a new quirk for AML mutex
      platform/chrome: cros_ec_lpc: Add quirks for Framework Laptop
      platform/chrome: cros_ec_lpc: Handle zero length read/write

Daisuke Nojiri (3):
      platform/chrome: Add struct ec_response_get_next_event_v3
      platform/chrome: cros_ec_proto: Upgrade get_next_event to v3
      dt-bindings: input: cros-ec-keyboard: Add keyboard matrix v3.0

Dan Carpenter (3):
      hwmon: (cros_ec) Prevent read overflow in probe()
      platform/chrome: cros_ec_lpc: Fix error code in cros_ec_lpc_mec_read_=
bytes()
      power: supply: cros_charge-control: Fix signedness bug in charge_beha=
viour_store()

Guenter Roeck (1):
      hwmon: (cros_ec) Fix access to restricted __le16

Jeff Johnson (1):
      platform/chrome: cros_ec_proto: add missing MODULE_DESCRIPTION() macro

Nathan Chancellor (1):
      power: supply: cros_charge-control: Avoid accessing attributes out of=
 bounds

Rob Barnes (1):
      platform/chrome: cros_ec_debugfs: Make log polling period a parameter

Thomas Wei=DFschuh (9):
      platform/chrome: cros_ec_proto: Fix cros_ec_get_host_event_wake_mask =
kdoc
      platform/chrome: cros_ec_proto: Fix cros_ec_get_host_command_version_=
mask kdoc
      platform/chrome: cros_ec_proto: Introduce cros_ec_cmd_readmem()
      hwmon: add ChromeOS EC driver
      ACPI: battery: add devm_battery_hook_register()
      platform/chrome: Update binary interface for EC-based charge control
      platform/chrome: cros_ec_proto: Introduce cros_ec_get_cmd_versions()
      power: supply: add ChromeOS EC based charge control driver
      power: supply: cros_charge-control: don't load if Framework control i=
s present

Tzung-Bi Shih (3):
      platform/chrome: cros_ec: let cros_ec_suspend() call cros_ec_suspend_*
      platform/chrome: cros_ec_proto: update Kunit test for get_next_data_v3
      platform/chrome: cros_ec_debugfs: fix wrong EC message version

 Documentation/hwmon/cros_ec_hwmon.rst          |  26 ++
 Documentation/hwmon/index.rst                  |   1 +
 MAINTAINERS                                    |  14 +
 drivers/acpi/battery.c                         |  15 ++
 drivers/hwmon/Kconfig                          |  11 +
 drivers/hwmon/Makefile                         |   1 +
 drivers/hwmon/cros_ec_hwmon.c                  | 283 ++++++++++++++++++++
 drivers/platform/chrome/cros_ec.c              |   4 +-
 drivers/platform/chrome/cros_ec_debugfs.c      |   9 +-
 drivers/platform/chrome/cros_ec_lpc.c          | 210 +++++++++++----
 drivers/platform/chrome/cros_ec_lpc_mec.c      |  91 ++++++-
 drivers/platform/chrome/cros_ec_lpc_mec.h      |  18 +-
 drivers/platform/chrome/cros_ec_proto.c        |  95 ++++++-
 drivers/platform/chrome/cros_ec_proto_test.c   |   9 +-
 drivers/platform/chrome/wilco_ec/mailbox.c     |  22 +-
 drivers/power/supply/Kconfig                   |  12 +
 drivers/power/supply/Makefile                  |   1 +
 drivers/power/supply/cros_charge-control.c     | 352 +++++++++++++++++++++=
++++
 include/acpi/battery.h                         |   2 +
 include/dt-bindings/input/cros-ec-keyboard.h   | 104 ++++++++
 include/linux/platform_data/cros_ec_commands.h |  83 +++++-
 include/linux/platform_data/cros_ec_proto.h    |   6 +-
 22 files changed, 1270 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/hwmon/cros_ec_hwmon.rst
 create mode 100644 drivers/hwmon/cros_ec_hwmon.c
 create mode 100644 drivers/power/supply/cros_charge-control.c

--d6zfrOryeugXFBGg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZpSiTQAKCRArxTEGBto8
9LfLAQC9z5N/bpJ5tiPJxIVH0fw5ByDUkg4ZcpJAoINnQd8BeAEAuOb6iIppBVDy
xmu6xdYG0PBMBAg50Pe2nO6/odLJBA4=
=UnzV
-----END PGP SIGNATURE-----

--d6zfrOryeugXFBGg--

