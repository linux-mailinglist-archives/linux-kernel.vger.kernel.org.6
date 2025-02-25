Return-Path: <linux-kernel+bounces-530751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A264A437D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943471899054
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65325EFBC;
	Tue, 25 Feb 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPGaAN7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A6170A26;
	Tue, 25 Feb 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472880; cv=none; b=iJd31PkAxd1k+JRC8bjpupP+18ebzBLKEl0TgG0Aoexb8fRqhHuG5cFOGlHWF7tLXC4miLbQvd8O4osQGDyPjXdb0aT0vhrp/OS0Mo8Rc4MzoTiVUKSpZcmxWXHiUcoQ2ANfwZ0p99sJ+3OgzoRsTk3AS7prIWPXc6lw6Oo8dAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472880; c=relaxed/simple;
	bh=vIQYdyOEzWu+41zMz1p5OCKUmlP+4f9CSqgxogleOFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2Ts/kmWYf3/cNE6oYyex/o3neiINXjt5pOHaEEMJ8NcX2CQp3YuvrkZw0ychOtY44qrdccZXFt1qiqnYxjxddXg5nR98P6PAvK9qDV0yu2WMuEDkjA+eKeo+n4c8FEGpSBrBL3arzOW16KBWMUNDAJILYqhwRhzX57cf1N/d/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPGaAN7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35A7C4CEDD;
	Tue, 25 Feb 2025 08:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740472880;
	bh=vIQYdyOEzWu+41zMz1p5OCKUmlP+4f9CSqgxogleOFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPGaAN7Th6HycsZsaacoGSR8Dh0cuUxMZZBWi83PHwXsPLxStxPX493fz1Ak3+bDX
	 lg8PgRxXJ45npe2td1IoNrj72tEvuWP99SJEev2chGJiPjIM7oX1Z9F3KZmFiqOCtN
	 6kTIa26b4cquFXyMe/zEK5KXicpDMKw/UStlP+1RcqFJgmdPD0Z4guSJrmuj0v1tf5
	 klOmsqt+286Frm4FhriFVmtcoiluXP+EDTgSCSdqdnFP9fRvN7FiPZNLU+o6dNSbdK
	 FNjbfJseEoroqFVXzzB/MoDDSx3Sb05WNL6pTEyzjJC0hZuHIYtGq2qovxejg6b5yB
	 5F5kkB+NfP1MQ==
Date: Tue, 25 Feb 2025 09:41:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <20250225-delicate-tortoise-of-management-e43fa2@krzk-bin>
References: <20250224155500.52462-1-francesco@dolcini.it>
 <20250224155500.52462-4-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224155500.52462-4-francesco@dolcini.it>

On Mon, Feb 24, 2025 at 04:54:58PM +0100, Francesco Dolcini wrote:
> +  wlf,drc-cfg-regs:
> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> +    description:
> +      Default register values for R40/41/42/43 (DRC).
> +      The list must be 4 times the length of wlf,drc-cfg-names.
> +      If absent, DRC is disabled.
> +
> +  wlf,retune-mobile-cfg-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description:
> +      List of strings for the available retune modes.
> +      If absent, retune is disabled.

How is this retune supposed to be used? If by user-space I can easily
imagine that static DTS configuration won't be enough, because you need
to factor for example temperature or some other minor differences
between same boards.

> +
> +  wlf,retune-mobile-cfg-rates:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Drop

> +    description:
> +      List of rates for the available retune modes.

Use standard property suffixes - hz or whatever is matching here.

> +      The list must be the same length as wlf,retune-mobile-cfg-names.
> +      If absent, retune is disabled.
> +
> +  wlf,retune-mobile-cfg-regs:
> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> +    description:
> +      Default register values for R134/.../157 (EQ).
> +      The list must be 24 times the length of wlf,retune-mobile-cfg-names.
> +      If absent, retune is disabled.
> +
> +dependencies:
> +  wlf,drc-cfg-names: [ 'wlf,drc-cfg-regs' ]
> +  wlf,drc-cfg-regs: [ 'wlf,drc-cfg-names' ]
> +
> +  wlf,retune-mobile-cfg-names: [ 'wlf,retune-mobile-cfg-rates', 'wlf,retune-mobile-cfg-regs' ]
> +  wlf,retune-mobile-cfg-regs: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-rates' ]
> +  wlf,retune-mobile-cfg-rates: [ 'wlf,retune-mobile-cfg-names', 'wlf,retune-mobile-cfg-regs' ]
> +
>  required:
>    - compatible
>    - reg
> @@ -70,5 +138,43 @@ examples:
>              DBVDD-supply = <&reg_1p8v>;
>              DCVDD-supply = <&reg_1p8v>;
>              MICVDD-supply = <&reg_1p8v>;
> +
> +            wlf,drc-cfg-names = "default", "peaklimiter", "tradition", "soft", "music";
> +            wlf,drc-cfg-regs =
> +                /* coded default: KNEE_IP = KNEE_OP = 0, HI_COMP = LO_COMP = 1  */

Please follow DTS coding style - how you wrap, where to break lines.

> +                /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
> +                /* coded default: KNEE_IP = -24, KNEE_OP = -6, HI_COMP = 1/4, LO_COMP = 1 */
> +                /bits/ 16 <0x04af 0x324b 0x0010 0x0408>,
> +                /* coded default: KNEE_IP = -42, KNEE_OP = -3, HI_COMP = 0, LO_COMP = 1 */
> +                /bits/ 16 <0x04af 0x324b 0x0028 0x0704>,
> +                /* coded default: KNEE_IP = -45, KNEE_OP = -9, HI_COMP = 1/8, LO_COMP = 1 */
> +                /bits/ 16 <0x04af 0x324b 0x0018 0x078c>,
> +                /* coded default: KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1 */
> +                /bits/ 16 <0x04af 0x324b 0x0010 0x050e>;
> +
> +            wlf,gpio-cfg = <

There is almost never empty line after <

> +                0x0018 /* GPIO1 => DMIC_CLK */
> +                0xffff /* GPIO2 => don't touch */
> +                0xffff /* GPIO3 => don't touch */
> +                0xffff /* GPIO4 => don't touch */

Not mentioning this looks really incorrect or incomplete. No ending of
property.

> +
> +            wlf,retune-mobile-cfg-names = "bassboost", "bassboost", "treble";
> +            wlf,retune-mobile-cfg-rates = <48000 44100 48000>;
> +            wlf,retune-mobile-cfg-regs =
> +                /* bassboost: EQ_ENA = 1, +6 dB @ 100 Hz, +3 dB @ 300 Hz, 0 dB @ 875, 2400, 6900 Hz */
> +                /bits/ 16 <0x1 0x12 0xf 0xc 0xc 0xc>,
> +                /* default values for ReTune Mobile registers 140-157 */
> +                /bits/ 16 <0x0fca 0x0400 0x00d8 0x1eb5 0xf145 0x0bd5 0x0075 0x1c58 0xf3d3 0x0a54 0x0568 0x168e 0xf829 0x07ad 0x1103 0x0564 0x0559 0x4000>,

See DTS coding style.

Best regards,
Krzysztof


