Return-Path: <linux-kernel+bounces-320287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC1970862
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CDFB2149A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F4172BDE;
	Sun,  8 Sep 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzxzhB18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B136B0D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725808694; cv=none; b=GrTgE7wnGSIwnwKRLPq8lNZONPuIavRH9MqS1KVk9LWxD6iPvDbfPn94dqDIIkyPpMxFVZN1GRr3R4N4KjMYRryADE3uuY4z4uCN/RkyuRF1wwriyj2Zml5Hx9JaIlvvJ3oTtQhauQNLKZiX6F1FIVYFHw1rsOQwodfg3pkc2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725808694; c=relaxed/simple;
	bh=me/RfXv4m3863MDF2iMXaivbpwAD1QHQrY/y8muO+Iw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=sqkkEw57ZGr+O64Z7AGv8IXWO7dFbMe8eSt2ab6vBJ5NWdCbe5u6WqUbcKi8lkOxyN0RaqhUEX61ERk/UuZGh8lEIuhw9eO91jKpinJn0lPBjrftiK1v6ZOwyw1s0u1PoLJrym/dN4qieHda/ptdlrCuKg7By69TQo+J3Rc8bPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzxzhB18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71032C4CEC3;
	Sun,  8 Sep 2024 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725808694;
	bh=me/RfXv4m3863MDF2iMXaivbpwAD1QHQrY/y8muO+Iw=;
	h=Date:From:To:Cc:Subject:From;
	b=BzxzhB183/8bk5iVTc5OY4bGyTbiL7E0OeS/ioO5uw9WGCXKTcuWjzAqAuajnmQ/b
	 qdNk8mUwfH8OD4JQj9ElKhwlePaWuPirrFniwHTcGl2aPU0NZHHGkx4VaDxdtsTF3i
	 IqeZZDs+pP4XTJbo2vRCQH5VF3qzQmA8B9h/FHXs/IY5eIe4wHcR8/WbdV5EeRJGzS
	 43XYoeKS7R3hcIBC+QeNKMpqPreaAFTDt4OpV389fSppiUx2kn9cA4FGJoGMEUdyv3
	 J/vf32czwWX8GlAa3vTSJMjcdrz0LbL+ytG/NZiGeh+e2nskc00tNbQy6nRc1K7a7O
	 u5UgPFII2pbGg==
Message-ID: <aac3f30a-bab1-4a45-a69d-050b15ead4a8@kernel.org>
Date: Mon, 9 Sep 2024 00:18:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [GIT PULL] extcon next for v6.12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Greg,

This is extcon-next pull request for v6.12. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.12

for you to fetch changes up to 2e01ac83c1c7166e58043ff2bdb0dc7dbfcfd11a:

  extcon: lc824206xa: Fix build error of POWER_SUPPLY_PROP_USB_TYPE (2024-09-05 01:44:51 +0900)

----------------------------------------------------------------
Update extcon next for v6.12

Detailed description for this pull request:
- Add missing child node port on exttcon-ptn5150 binding document

- Convert extcon-usb-gpio.txt to yaml format for binding document

- Add new LC824206XA microUSB switch driver
 : Add a new driver for the ON Semiconductor LC824206XA microUSB switch and
   accessory detector chip. It has been tested on a Lenovo Yoga Tablet 2 Pro
   1380. And this driver is only used on x86/ACPI (non devicetree) devices,
   Therefor there is no devicetree bindings documentation.

- Apply immutable branch between power_supply and extcon tree for extcon-lc824206xa.c
----------------------------------------------------------------

Chanwoo Choi (1):
      Merge tag 'ib-psy-usb-types-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply into extcon-next

Frank Li (2):
      dt-bindings: extcon: ptn5150: add child node port
      dt-bindings: extcon: convert extcon-usb-gpio.txt to yaml format

Hans de Goede (7):
      power: supply: "usb_type" property may be written to
      power: supply: ucs1002: Adjust ucs1002_set_usb_type() to accept string values
      power: supply: rt9467-charger: Remove "usb_type" property write support
      power: supply: sysfs: Add power_supply_show_enum_with_available() helper
      power: supply: sysfs: Move power_supply_show_enum_with_available() up
      power: supply: Change usb_types from an array into a bitmask
      extcon: Add LC824206XA microUSB switch driver

Stephen Rothwell (1):
      extcon: lc824206xa: Fix build error of POWER_SUPPLY_PROP_USB_TYPE

 Documentation/ABI/testing/sysfs-class-power        |   7 +-
 .../devicetree/bindings/extcon/extcon-ptn5150.yaml |  11 +
 .../devicetree/bindings/extcon/extcon-usb-gpio.txt |  21 -
 .../bindings/extcon/linux,extcon-usb-gpio.yaml     |  37 ++
 drivers/extcon/Kconfig                             |  11 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-intel-cht-wc.c               |  15 +-
 drivers/extcon/extcon-lc824206xa.c                 | 495 +++++++++++++++++++++
 drivers/phy/ti/phy-tusb1210.c                      |  11 +-
 drivers/power/supply/axp20x_usb_power.c            |  13 +-
 drivers/power/supply/bq256xx_charger.c             |  15 +-
 drivers/power/supply/cros_usbpd-charger.c          |  22 +-
 drivers/power/supply/lenovo_yoga_c630_battery.c    |   7 +-
 drivers/power/supply/mp2629_charger.c              |  15 +-
 drivers/power/supply/mt6360_charger.c              |  13 +-
 drivers/power/supply/mt6370-charger.c              |  13 +-
 drivers/power/supply/power_supply_core.c           |   4 -
 drivers/power/supply/power_supply_sysfs.c          |  66 +--
 drivers/power/supply/qcom_battmgr.c                |  37 +-
 drivers/power/supply/qcom_pmi8998_charger.c        |  13 +-
 drivers/power/supply/rk817_charger.c               |   9 +-
 drivers/power/supply/rn5t618_power.c               |  13 +-
 drivers/power/supply/rt9467-charger.c              |  16 +-
 drivers/power/supply/rt9471.c                      |  15 +-
 drivers/power/supply/ucs1002_power.c               |  26 +-
 drivers/usb/typec/anx7411.c                        |  11 +-
 drivers/usb/typec/rt1719.c                         |  11 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  11 +-
 drivers/usb/typec/tipd/core.c                      |   9 +-
 drivers/usb/typec/ucsi/psy.c                       |  11 +-
 include/linux/power_supply.h                       |   3 +-
 31 files changed, 687 insertions(+), 275 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
 create mode 100644 drivers/extcon/extcon-lc824206xa.c

