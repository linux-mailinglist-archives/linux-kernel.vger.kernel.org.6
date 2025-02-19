Return-Path: <linux-kernel+bounces-521635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1017CA3C020
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0271188A538
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5C1EA7C0;
	Wed, 19 Feb 2025 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGkh5SJt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01FF15B971;
	Wed, 19 Feb 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972282; cv=none; b=e6Lc9VKXI5oEO0PErtqpQn14pozyYBbUaVnPbcO2Bnom58F1WvDsKO7jbdvcktpY1FMwSo8hJCeT4yXzHWC1U4dAJVajoX6gkb8Gmi5C4lWZrI5ibK5XujoZB5x28WFN0grSiT6q7g+IKJDtfGpmNfslchHC+PAM9sQQuQtgx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972282; c=relaxed/simple;
	bh=UZOTZjAmK9GpEVopumc45bM7a93tdAVwiLa2wCKSe/k=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cbxo1ViQX/FyPwTVNHpeyslieoAVjaAQKczJyWTTNhlbSacD7HoVwVEEFWZqA++4LX6gdTXTm7ZWKL33GowFl6CfFYx8QKc0ws2/skxzlXum/F0do8BuQoUDsUayyCw8WAISQbdjjWTHpOA9g1S03GyjYfEj4p5Q21tkSnmmzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGkh5SJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D059C4CED1;
	Wed, 19 Feb 2025 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739972282;
	bh=UZOTZjAmK9GpEVopumc45bM7a93tdAVwiLa2wCKSe/k=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=nGkh5SJt2AfbLooasJ7aDYiL5IwRv0RrdZ6C6llXWNg1TMwY6t3WsWftaW6OeAk/m
	 Vp246xypjQIJxyiIz3g2mkP7MGS6NPw1h9aKeVusjSHn4t48IN06VMjjtqjHfIpc4d
	 0QtDT9WY/EdnlCnEz2g76nGL3m4F8OA0zPOubQ3HBTS6sRNLyjsxTcbmePZf5eyYVk
	 uBzVgicyYQdX9i/j+LcfRO+Q87fpUx3ftjrL7r65GB49Wu+uUid2JOrRwufZbWGMBa
	 Ud530pmz7LlHXpvLUn5uQ9Co2lxPTq7OpXZZh04FtNqDbeKdgInQOmFnv4sHLhFBus
	 qRIfEEQ59l8MQ==
Date: Wed, 19 Feb 2025 07:38:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: shufan_lee@richtek.com, heikki.krogerus@linux.intel.com, 
 andre.draszik@linaro.org, kernel@collabora.com, linux@roeck-us.net, 
 linux-kernel@vger.kernel.org, pablo.sun@mediatek.com, 
 linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250219122206.46695-1-angelogioacchino.delregno@collabora.com>
References: <20250219122206.46695-1-angelogioacchino.delregno@collabora.com>
Message-Id: <173997222717.2335452.4745248344825352712.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] MediaTek MT8188 MTU3 USB and Genio 510/700
 TypeC


On Wed, 19 Feb 2025 13:22:04 +0100, AngeloGioacchino Del Regno wrote:
> This series adds MTU3 nodes to the MT8188 base devicetree, fixes the
> Geralt Chromebooks to use it, and adds support for all of the USB
> ports, including TypeC Power Delivery, Alternate Modes, etc, found
> on the MediaTek Genio 510 and Genio 700 Evaluation Kits.
> 
> 
> AngeloGioacchino Del Regno (2):
>   arm64: dts: mediatek: mt8188: Add MTU3 nodes and correctly describe
>     USB
>   arm64: dts: mediatek: mt8390-genio: Add USB, TypeC Controller, MUX
> 
>  .../boot/dts/mediatek/mt8188-geralt.dtsi      |  18 ++
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 121 +++++++++-----
>  .../dts/mediatek/mt8390-genio-common.dtsi     | 155 +++++++++++++++++-
>  3 files changed, 251 insertions(+), 43 deletions(-)
> 
> --
> 2.48.1
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250219122206.46695-1-angelogioacchino.delregno@collabora.com:

arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: usb@11201000: usb@0: 'port', 'vdd-supply' do not match any of the regexes: '@[0-9a-f]{1}$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtu3.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: usb@0: 'port', 'vdd-supply' do not match any of the regexes: '@[0-9a-f]{1}$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: usb@11201000: usb@0: 'port', 'vdd-supply' do not match any of the regexes: '@[0-9a-f]{1}$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtu3.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: usb@0: 'port', 'vdd-supply' do not match any of the regexes: '@[0-9a-f]{1}$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: usb@112a1000: usb@0: {'compatible': ['mediatek,mt8188-xhci', 'mediatek,mtk-xhci'], 'reg': [[0, 0, 0, 4096]], 'reg-names': ['mac'], 'interrupts': [[0, 536, 4, 0]], 'assigned-clocks': [[38, 46]], 'assigned-clock-parents': [[38, 118]], 'clocks': [[54, 8]], 'clock-names': ['sys_ck'], 'status': ['okay'], 'interrupts-extended': [[1, 0, 536, 4, 0], [35, 220, 4]], 'interrupt-names': ['host', 'wakeup'], 'vusb33-supply': [[74]], 'vbus-supply': [[104]]} is valid under each of {'required': ['interrupts-extended']}, {'required': ['interrupts']}
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtu3.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: usb@0: {'compatible': ['mediatek,mt8188-xhci', 'mediatek,mtk-xhci'], 'reg': [[0, 0, 0, 4096]], 'reg-names': ['mac'], 'interrupts': [[0, 536, 4, 0]], 'assigned-clocks': [[38, 46]], 'assigned-clock-parents': [[38, 118]], 'clocks': [[54, 8]], 'clock-names': ['sys_ck'], 'status': ['okay'], 'interrupts-extended': [[1, 0, 536, 4, 0], [35, 220, 4]], 'interrupt-names': ['host', 'wakeup'], 'vusb33-supply': [[74]], 'vbus-supply': [[104]], '$nodename': ['usb@0']} is valid under each of {'required': ['interrupts-extended']}, {'required': ['interrupts']}
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: usb@112a1000: usb@0: {'compatible': ['mediatek,mt8188-xhci', 'mediatek,mtk-xhci'], 'reg': [[0, 0, 0, 4096]], 'reg-names': ['mac'], 'interrupts': [[0, 536, 4, 0]], 'assigned-clocks': [[36, 46]], 'assigned-clock-parents': [[36, 118]], 'clocks': [[52, 8]], 'clock-names': ['sys_ck'], 'status': ['okay'], 'interrupts-extended': [[1, 0, 536, 4, 0], [33, 220, 4]], 'interrupt-names': ['host', 'wakeup'], 'vusb33-supply': [[72]], 'vbus-supply': [[102]]} is valid under each of {'required': ['interrupts-extended']}, {'required': ['interrupts']}
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtu3.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: usb@0: {'compatible': ['mediatek,mt8188-xhci', 'mediatek,mtk-xhci'], 'reg': [[0, 0, 0, 4096]], 'reg-names': ['mac'], 'interrupts': [[0, 536, 4, 0]], 'assigned-clocks': [[38, 46]], 'assigned-clock-parents': [[38, 118]], 'clocks': [[54, 8]], 'clock-names': ['sys_ck'], 'status': ['okay'], 'interrupts-extended': [[1, 0, 536, 4, 0], [35, 220, 4]], 'interrupt-names': ['host', 'wakeup'], 'vusb33-supply': [[74]], 'vbus-supply': [[104]], '$nodename': ['usb@0']} is valid under each of {'required': ['interrupts-extended']}, {'required': ['interrupts']}
	from schema $id: http://devicetree.org/schemas/interrupts.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: usb@0: {'compatible': ['mediatek,mt8188-xhci', 'mediatek,mtk-xhci'], 'reg': [[0, 0, 0, 4096]], 'reg-names': ['mac'], 'interrupts': [[0, 536, 4, 0]], 'assigned-clocks': [[36, 46]], 'assigned-clock-parents': [[36, 118]], 'clocks': [[52, 8]], 'clock-names': ['sys_ck'], 'status': ['okay'], 'interrupts-extended': [[1, 0, 536, 4, 0], [33, 220, 4]], 'interrupt-names': ['host', 'wakeup'], 'vusb33-supply': [[72]], 'vbus-supply': [[102]], '$nodename': ['usb@0']} is valid under each of {'required': ['interrupts-extended']}, {'required': ['interrupts']}
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: usb@0: {'compatible': ['mediatek,mt8188-xhci', 'mediatek,mtk-xhci'], 'reg': [[0, 0, 0, 4096]], 'reg-names': ['mac'], 'interrupts': [[0, 536, 4, 0]], 'assigned-clocks': [[36, 46]], 'assigned-clock-parents': [[36, 118]], 'clocks': [[52, 8]], 'clock-names': ['sys_ck'], 'status': ['okay'], 'interrupts-extended': [[1, 0, 536, 4, 0], [33, 220, 4]], 'interrupt-names': ['host', 'wakeup'], 'vusb33-supply': [[72]], 'vbus-supply': [[102]], '$nodename': ['usb@0']} is valid under each of {'required': ['interrupts-extended']}, {'required': ['interrupts']}
	from schema $id: http://devicetree.org/schemas/interrupts.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: rt1715@4e: 'vbus-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: rt1715@4e: 'vbus-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: jpeg-decoder@1a040000: iommus: [[139, 685], [139, 686], [139, 690], [139, 691], [139, 692], [139, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: jpeg-decoder@1a040000: iommus: [[137, 685], [137, 686], [137, 690], [137, 691], [137, 692], [137, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#






