Return-Path: <linux-kernel+bounces-336055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F8A97EE87
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7081C21715
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DEE199EB4;
	Mon, 23 Sep 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENQwd0C+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6926AFF
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106658; cv=none; b=uXlD8PzCMzfSA/iEqsTSwSDu7M+xW44zhYrGk9JOMLERxSCL9EdL/E5Zr6TlaD8Fp144melDis3DA4+o8R7AL1l77kuqxCVzAlGGNZI6UWGuTFoq9qICMJXRKBNpeVr/2R9tScWfFERSHGPYajmtjnb8He35dtwi7/3/fEPNHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106658; c=relaxed/simple;
	bh=C6IYc69c062N/vAttS5PkFBgas85TidcSpBcCAu9u9U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jGFq6coaQ2SpDvWdjJEZ8ZPMXWw5J03xQknkRBTcMJ6jtJEGijzcG/e8h1YWNV4PB73xnYBrH++WYI5mp/N/6WJXO++zzJsR1uvguqSZOoU+srQ2Eu5NoRhp6bS9NAbiKdExqWHSQfq+gK5ChM4iuylyE5e6d/KOYW3e2GWmj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENQwd0C+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E4C4CEC4;
	Mon, 23 Sep 2024 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727106657;
	bh=C6IYc69c062N/vAttS5PkFBgas85TidcSpBcCAu9u9U=;
	h=Date:From:To:Cc:Subject:From;
	b=ENQwd0C+g45arc+nUATD0vx/udtes0E5tO1/daDHL71j9eB+5v2WvgOr9InzYN15w
	 wZ/eRnqeUHHirAzlEDmX8yOnuj7e0ZCFOlj6jHJdXa7ZK9xODcpn7eZOFqwtg4meUv
	 s9mTnSiBhzDXfUMHmozsoRma60PkSvMwafNa/yF+NoByd1/8yDh9ukZrz6h3cvkaTP
	 4mMzK+1ys2tkwi19p/V6HygLyekQ3AQXmTnOvKp+YQ9F7vvbbAC8RBrmP9gYcL+mR3
	 O31u78HkNLq54bRViI5X70upoldBmG7unRjumEtd7WZaWtAqZn8pw2+aQ82V/aJsbt
	 pIYeTSUsYY/3Q==
Date: Mon, 23 Sep 2024 16:50:54 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.12
Message-ID: <20240923155054.GB7545@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good afternoon Linus,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.12

for you to fetch changes up to 64c38866500b0bda4363fb994d545557dffb017c:

  leds: turris-omnia: Fix module autoloading with MODULE_DEVICE_TABLE() (2024-08-30 09:05:08 +0100)

----------------------------------------------------------------
- Limited LED current based on thermal conditions in the QCOM flash LED driver.
- Fixed device child node usage in the BD2606MVV and PCA995x drivers.
- Used device_for_each_child_node_scoped() to access child nodes in the IS31FL319X driver.
- Reset the LED controller during the probe in the LM3601X driver.
- Used device_for_each_child_node() to access device child nodes in the PCA995X driver.
- Fixed CONFIG_LEDS_CLASS_MULTICOLOR dependency in the BlinkM driver.
- Replaced msleep() with usleep_range() in the SUN50I-A100 driver.
- Used scoped device node handling to simplify error paths in the AAT1290, KTD2692, and MC13783 drivers.
- Added missing of_node_get for probe duration in the MAX77693 driver.
- Simplified using for_each_available_child_of_node_scoped() loops when iterating over device nodes.
- Used devm_clk_get_enabled() helpers in the LP55XX driver.
- Converted DT bindings from TXT to YAML format for various drivers, including LM3692x and SC2731-BLTC.
- Set num_leds after allocation in the GPIO driver.
- Removed irrelevant blink configuration error message in the PCA9532 driver.
- Fixed module autoloading with MODULE_DEVICE_TABLE() in the Turris Omnia driver.

----------------------------------------------------------------
Abhishek Tamboli (1):
      leds: sun50i-a100: Replace msleep() with usleep_range()

Arnd Bergmann (1):
      leds: blinkm: Fix CONFIG_LEDS_CLASS_MULTICOLOR dependency

Bastien Curutchet (1):
      leds: pca9532: Remove irrelevant blink configuration error message

Fenglin Wu (1):
      leds: flash: leds-qcom-flash: Limit LED current based on thermal condition

Frank Li (1):
      dt-bindings: leds: Convert leds-lm3692x to YAML format

Huan Yang (1):
      leds: lp55xx: Use devm_clk_get_enabled() helpers

Jack Chen (2):
      leds: lm3601x: Calculate max_brightness and brightness properly
      leds: lm3601x: Reset LED controller during probe

Javier Carrasco (5):
      leds: bd2606mvv: Fix device child node usage in bd2606mvv_probe()
      leds: is31fl319x: Use device_for_each_child_node_scoped() to access child nodes
      leds: pca995x: Use device_for_each_child_node() to access device child nodes
      leds: pca995x: Fix device child node usage in pca995x_probe()
      leds: as3645a: Use device_* to iterate over device child nodes

Joseph Strauss (1):
      leds: Add multicolor support to BlinkM LED driver

Kees Cook (1):
      leds: gpio: Set num_leds after allocation

Krzysztof Kozlowski (17):
      leds: aat1290: Use scoped device node handling to simplify error paths
      leds: ktd2692: Use scoped device node handling to simplify error paths
      leds: max77693: Add missing of_node_get for probe duration
      leds: max77693: Simplify with scoped for each OF child loop
      leds: 88pm860x: Simplify with scoped for each OF child loop
      leds: aw2013: Simplify with scoped for each OF child loop
      leds: bcm6328: Simplify with scoped for each OF child loop
      leds: bcm6358: Simplify with scoped for each OF child loop
      leds: is31fl32xx: Simplify with scoped for each OF child loop
      leds: lp55xx: Simplify with scoped for each OF child loop
      leds: mc13783: Use scoped device node handling to simplify error paths
      leds: mt6323: Simplify with scoped for each OF child loop
      leds: netxbig: Simplify with scoped for each OF child loop
      leds: pca9532: Simplify with scoped for each OF child loop
      leds: sc27xx: Simplify with scoped for each OF child loop
      leds: turris-omnia: Simplify with scoped for each OF child loop
      leds: qcom-lpg: Simplify with scoped for each OF child loop

Liao Chen (1):
      leds: turris-omnia: Fix module autoloading with MODULE_DEVICE_TABLE()

Lukasz Majewski (1):
      leds: trigger: netdev: Add support for tx_err and rx_err notification with LEDs

Marek Vasut (1):
      dt-bindings: leds: Document "netdev" trigger

Pieterjan Camerlynck (2):
      dt-bindings: leds: pca995x: Add new nxp,pca9956b compatible
      leds: leds-pca995x: Add support for NXP PCA9956B

Stanislav Jakubek (1):
      dt-bindings: leds: sc2731-bltc: Convert to YAML

 Documentation/devicetree/bindings/leds/common.yaml |   2 +
 .../devicetree/bindings/leds/leds-lm3692x.txt      |  65 ------
 .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |  43 ----
 .../devicetree/bindings/leds/nxp,pca995x.yaml      |   6 +-
 .../devicetree/bindings/leds/sprd,sc2731-bltc.yaml |  84 ++++++++
 .../devicetree/bindings/leds/ti.lm36922.yaml       | 110 +++++++++++
 Documentation/leds/leds-blinkm.rst                 |  29 ++-
 Documentation/leds/well-known-leds.txt             |   8 +
 drivers/leds/Kconfig                               |   8 +
 drivers/leds/flash/leds-aat1290.c                  |  14 +-
 drivers/leds/flash/leds-as3645a.c                  |   8 +-
 drivers/leds/flash/leds-ktd2692.c                  |  15 +-
 drivers/leds/flash/leds-lm3601x.c                  |  19 +-
 drivers/leds/flash/leds-max77693.c                 |  20 +-
 drivers/leds/flash/leds-qcom-flash.c               | 163 ++++++++++++++-
 drivers/leds/leds-88pm860x.c                       |   5 +-
 drivers/leds/leds-aw2013.c                         |   8 +-
 drivers/leds/leds-bcm6328.c                        |   7 +-
 drivers/leds/leds-bcm6358.c                        |   7 +-
 drivers/leds/leds-bd2606mvv.c                      |  23 +--
 drivers/leds/leds-blinkm.c                         | 220 ++++++++++++++-------
 drivers/leds/leds-gpio.c                           |   9 +-
 drivers/leds/leds-is31fl319x.c                     |  34 ++--
 drivers/leds/leds-is31fl32xx.c                     |  14 +-
 drivers/leds/leds-lp55xx-common.c                  |  22 +--
 drivers/leds/leds-lp55xx-common.h                  |   1 -
 drivers/leds/leds-mc13783.c                        |  24 ++-
 drivers/leds/leds-mt6323.c                         |  22 +--
 drivers/leds/leds-netxbig.c                        |  19 +-
 drivers/leds/leds-pca9532.c                        |  12 +-
 drivers/leds/leds-pca995x.c                        |  78 +++++---
 drivers/leds/leds-sc27xx-bltc.c                    |  12 +-
 drivers/leds/leds-sun50i-a100.c                    |   2 +-
 drivers/leds/leds-turris-omnia.c                   |   9 +-
 drivers/leds/rgb/leds-qcom-lpg.c                   |  14 +-
 drivers/leds/trigger/ledtrig-netdev.c              |  24 ++-
 include/linux/leds.h                               |   2 +
 37 files changed, 756 insertions(+), 406 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-lm3692x.txt
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
 create mode 100644 Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti.lm36922.yaml

-- 
Lee Jones [李琼斯]

