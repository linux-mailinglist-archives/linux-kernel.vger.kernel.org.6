Return-Path: <linux-kernel+bounces-538683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68FA49BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A467E3AD43E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7954D26FDAB;
	Fri, 28 Feb 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCqUrCKW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68A26FA7D;
	Fri, 28 Feb 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752639; cv=none; b=NYplD8SiYK8Wi3PQMLWOsXlDeSDB2bc7gjV7rcDj35Fi2eXm8+1k6krAm2dR/sE6o/cw9ry/VXLeNT8jkwsshZGRi2fHVjda/Et/LHHYuAqT00+wSwESMJXuxnlQBDmggvEVNBIU/5AueTRi2uoXuvMTKaz4XqI9h+A7+lFVIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752639; c=relaxed/simple;
	bh=Z7Ql+u5YzWqD85Qt5XHh+UJpa/CVhj/NNrypB2fEbOE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=sp/rUeJkDEbph02FhKeBqEHsnPqHNynQRg1pEOSnCGFB9oQ3L8rfYMGIyNlFQ0zJz+FYOTFZC5z2lfKfXc5NpWx7fWXrLafxkRiht5xlBGQfoXdGJqIRyHcPwCqj65CIhWp1zqAsYlkF2sohawaFUp1ZBwCk8mV3/LkuLbsuSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCqUrCKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC3DC4CED6;
	Fri, 28 Feb 2025 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740752639;
	bh=Z7Ql+u5YzWqD85Qt5XHh+UJpa/CVhj/NNrypB2fEbOE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=vCqUrCKWlROX8qqb+alRvT9d1dHuXdSRM7IJ8P5HQF/P161M4IVJfrXPHgBMd/HIE
	 R4NLkwfue3o+ZAfjnp7Z4UqzOSQdfJFSaTnRWC5gK7WAtRPcMPJwOhnNA//QtkkFlN
	 Eme9Zd9QA8vqnyPSKDi4s1c+XKYqnG3f/KRFlotQs+C77uLWh95eDHGMsYDxJroyHh
	 uqvy4a5u0JB5VoyDsry3RGgqdir0wKjBXHehEjxB+9364DRAWGdTkJ3vm2NLOppiy5
	 d4+FIdQDoVrWauwVSQ6xiJC9loR3ebCWeq1C+g8fv6uGbhhZ2PxyQ0DpVubK5YtHc9
	 zfS4wV68oomwQ==
Date: Fri, 28 Feb 2025 08:23:57 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 linux-amlogic@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-sound@vger.kernel.org, zhe.wang@amlogic.com, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 jian.xu@amlogic.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 shuai.li@amlogic.com, linux-kernel@vger.kernel.org, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>
To: jiebing chen <jiebing.chen@amlogic.com>
In-Reply-To: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
Message-Id: <174075232847.2756181.14032687393614819238.robh@kernel.org>
Subject: Re: [PATCH v3 0/6] Add support for S4 audio


On Fri, 28 Feb 2025 16:04:08 +0800, jiebing chen wrote:
> Add s4 audio base driver.
> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
> Changes in v3:
> - remove g12a tocodec switch event
> - Modify the incorrect title for dt-bindings
> - Link to v2: https://lore.kernel.org/r/20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com
> 
> Changes in v2:
> - remove tdm pad control and change tocodec base on g12a
> - change hifipll rate to support 24bit
> - add s4 audio clock
> - Link to v1: https://lore.kernel.org/r/20250113-audio_drvier-v1-0-8c14770f38a0@amlogic.com
> 
> ---
> jiebing chen (6):
>       dt-bindings: clock: meson: Add audio power domain for s4 soc
>       dt-bindings: clock: axg-audio: Add mclk and sclk pad clock ids
>       dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
>       clk: meson: axg-audio: Add the mclk pad div for s4
>       ASoC: meson: s4: Add s4 tocodec driver
>       arm64: dts: amlogic: Add Amlogic S4 Audio
> 
>  .../bindings/clock/amlogic,axg-audio-clkc.yaml     |  18 +
>  .../bindings/sound/amlogic,g12a-toacodec.yaml      |   1 +
>  .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     | 219 +++++++++++
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 371 ++++++++++++++++++-
>  drivers/clk/meson/axg-audio.c                      | 410 ++++++++++++++++++++-
>  drivers/clk/meson/axg-audio.h                      |   4 +
>  include/dt-bindings/clock/axg-audio-clkc.h         |  11 +
>  sound/soc/meson/g12a-toacodec.c                    |  51 +++
>  8 files changed, 1081 insertions(+), 4 deletions(-)
> ---
> base-commit: 6ecd20965bdc21b265a0671ccf36d9ad8043f5ab
> change-id: 20250110-audio_drvier-07a5381c494b
> 
> Best regards,
> --
> jiebing chen <jiebing.chen@amlogic.com>
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/amlogic/' for 20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com:

arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-1: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-1: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-1: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-1: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-2: clock-names:0: 'sclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-2: clock-names:1: 'lrclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-2: clock-names:2: 'mclk' was expected
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-2: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: sound: 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#






