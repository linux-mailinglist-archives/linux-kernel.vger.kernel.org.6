Return-Path: <linux-kernel+bounces-213744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC959079CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CCE1F24FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46214A0AD;
	Thu, 13 Jun 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiGYcrq4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA751304BF;
	Thu, 13 Jun 2024 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299636; cv=none; b=eg5gvG8ztsn0nhL7T5q0wBa7mx4u0gyR8PPYNGuW0fiRmXfdg9kxmTTQ2l1pn9AUd3Nd56u/MHLsCanysBKNSfXRAkHxVoGiZpxps7YTuxPxdv/uJX3NCH28g0LNbO2GDltUBTsJkQ9RxYVA+hpUhtwYiA8eoWCntPH+TbXyXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299636; c=relaxed/simple;
	bh=QmGHUd+e/PjYuv8/57wzZ877J2mB2nvVZfL6iFjG7tM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=oObb6WdxTtnmju3EdDK7IoZJ0abily8vw6o2qHP+hzmUoAiBCvsjmYY/v/DTJweu0dRO5+t+FLuDSSkYcwNCWJP8bDb7ogtIXcpWseusP08BMNvdf6q8vJQCy4vOqDBATO4GuSZYF2lf52bRlrfed+zjOS7g3xfo2wHWwRneGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiGYcrq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537E7C2BBFC;
	Thu, 13 Jun 2024 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718299635;
	bh=QmGHUd+e/PjYuv8/57wzZ877J2mB2nvVZfL6iFjG7tM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BiGYcrq4OSaFZAawU5+kEhyxy5h9CTqza9TtHfxn3ERWJgkMm1uufUVzzRyJeWQKN
	 mMioEzlk1qcVFL6eZfhz19bNI0MTTChoFv716sLJH34QBE0BmkyDRv2s4EAPhxeUWq
	 d0mGe/ptW83ZDRpc4bnZzH+9D+6a8SSHzHG9czpVmDl2tgTwYXQQ6AFaOLOL4o4jPA
	 r0869V14us0L+/UtZ/SoWWiZMvJMetGEPXIWTX4WYR5zKlg3uIQJAuNEUdE5Decbly
	 /FZK2DrIe2JU8KAw1R7RGuYzLkG9VSHyVXVGYGdNUfm5E0dRkRkYbqv4aDv5i6YSHX
	 Ji+9V66juyIRA==
Date: Thu, 13 Jun 2024 11:27:14 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Kropatsch <seb-dev@mail.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 devicetree@vger.kernel.org
In-Reply-To: <20240612205056.397204-1-seb-dev@mail.de>
References: <20240612205056.397204-1-seb-dev@mail.de>
Message-Id: <171829929814.2050024.4291220614091376028.robh@kernel.org>
Subject: Re: [PATCH 0/5] Refactor, fix and improve NanoPi R6 series


On Wed, 12 Jun 2024 22:48:09 +0200, Sebastian Kropatsch wrote:
> Hello,
> 
> This patch series fixes a lot of minor issues in the current devicetree
> for the FriendlyElec NanoPi R6 series (R6C and R6S), as well as adding
> support for the GPU and one USB3 port which was previously disabled.
> 
> To aid with these patches, I have refactored the devicetrees in such a
> way that they will now share a common dtsi source file in a similar
> fashion than what the NanoPi R5C and R5S are already doing.
> This makes changes which only affect one of the boards easier, less
> error-prone and more maintainable. Also we don't need to work with
> /delete-node/ and /delete-property/ this way :)
> 
> Cheers,
> Sebastian
> 
> PS: Additional comments in patch 2 and 3.
> 
> ---
> 
> Sebastian Kropatsch (5):
>   arm64: dts: rockchip: Add common definitions for NanoPi R6C and R6S
>   arm64: dts: rockchip: Fix regulators, gmac and naming on NanoPi
>     R6C/R6S
>   arm64: dts: rockchip: Improve LEDs on NanoPi R6C/R6S
>   arm64: dts: rockchip: Enable lower USB3 port on NanoPi R6C/R6S
>   arm64: dts: rockchip: Enable GPU on NanoPi R6C/R6S
> 
>  ...-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} | 242 +++---
>  .../boot/dts/rockchip/rk3588s-nanopi-r6c.dts  |  48 +-
>  .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 743 +-----------------
>  3 files changed, 193 insertions(+), 840 deletions(-)
>  copy arch/arm64/boot/dts/rockchip/{rk3588s-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} (81%)
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3588s-nanopi-r6c.dtb rockchip/rk3588s-nanopi-r6s.dtb' for 20240612205056.397204-1-seb-dev@mail.de:

arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dtb: leds: led-1:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
	'stmmac-0:01:link' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern', 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash', 'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget', 'usb-host', 'usbport']
	'stmmac-0:01:link' does not match '^cpu[0-9]*$'
	'stmmac-0:01:link' does not match '^hci[0-9]+-power$'
	'stmmac-0:01:link' does not match '^mmc[0-9]+$'
	'stmmac-0:01:link' does not match '^phy[0-9]+tx$'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dtb: leds: led-1: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dtb: leds: led-2:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
	'r8169-3-3100:00:link' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern', 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash', 'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget', 'usb-host', 'usbport']
	'r8169-3-3100:00:link' does not match '^cpu[0-9]*$'
	'r8169-3-3100:00:link' does not match '^hci[0-9]+-power$'
	'r8169-3-3100:00:link' does not match '^mmc[0-9]+$'
	'r8169-3-3100:00:link' does not match '^phy[0-9]+tx$'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dtb: leds: led-2: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: leds: led-1:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
	'stmmac-0:01:link' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern', 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash', 'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget', 'usb-host', 'usbport']
	'stmmac-0:01:link' does not match '^cpu[0-9]*$'
	'stmmac-0:01:link' does not match '^hci[0-9]+-power$'
	'stmmac-0:01:link' does not match '^mmc[0-9]+$'
	'stmmac-0:01:link' does not match '^phy[0-9]+tx$'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: leds: led-1: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: leds: led-2:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
	'r8169-3-3100:00:link' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern', 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash', 'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget', 'usb-host', 'usbport']
	'r8169-3-3100:00:link' does not match '^cpu[0-9]*$'
	'r8169-3-3100:00:link' does not match '^hci[0-9]+-power$'
	'r8169-3-3100:00:link' does not match '^mmc[0-9]+$'
	'r8169-3-3100:00:link' does not match '^phy[0-9]+tx$'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: leds: led-2: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: leds: led-3:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
	'r8169-4-4100:00:link' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern', 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash', 'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget', 'usb-host', 'usbport']
	'r8169-4-4100:00:link' does not match '^cpu[0-9]*$'
	'r8169-4-4100:00:link' does not match '^hci[0-9]+-power$'
	'r8169-4-4100:00:link' does not match '^mmc[0-9]+$'
	'r8169-4-4100:00:link' does not match '^phy[0-9]+tx$'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dtb: leds: led-3: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#






