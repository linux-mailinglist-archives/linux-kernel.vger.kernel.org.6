Return-Path: <linux-kernel+bounces-175025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37988C1945
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4DEB20CDC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03814129A7C;
	Thu,  9 May 2024 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMIa1+9V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393ED770E0;
	Thu,  9 May 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292825; cv=none; b=swBGIlQHwNQjMP+iXLWPVGaS+h97X6HYtJ2T/hEjn8eiuC4OFL8P1u10MaPJZLtHHfAYDJK5wDBd5c4Oiqd6FB47G0Pkq/nibClyFD8rYDlg3fGP52pBGNDlfmN7lSL7takEf3Z4nGKbSinwt9do29fsLTNwr8zYV43QFdJvB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292825; c=relaxed/simple;
	bh=HsXBbYKsnaH2cBNxCbmFsxNH4L35JJ8rnzTl2hLvMCA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Amsb1zWaWEl8RIvjxz8LgYlD1IgvY2Xr0dBoEN+Y9fc9frhGNVMf1xq1D0iioiFoiW0gbASTfwuciGI45w0PhwM+drHl/xS7cXUYJpdSshDHvfxW79nCsUJ0ZFoO/GpTPpFb1wpMBDaE89ekluLnBuqGsd7QbaiLun8z9I2jC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMIa1+9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9462BC116B1;
	Thu,  9 May 2024 22:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715292824;
	bh=HsXBbYKsnaH2cBNxCbmFsxNH4L35JJ8rnzTl2hLvMCA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nMIa1+9VKO+e1tZRZY1J27ygFKsItAYeEY0WnZ2gS4xAWON9xuiIzp5JHk14e4JVR
	 YCvpBBRmVL+ZcIfLdrAafXSiWdDLkOnVvgL+HKszgvlRpnrrxsJk/Ae+aQLoxI35Xj
	 BlamZ/Mmr/BReIi8DffdEfn+O2LcYk4n1JPTIUgiEZerM3kws7qi2PlOcMCtbcLKHk
	 3+BGzqu974gMMGcmR1qOnP7jpY/95gkF8jgC266QHH7fkER2qpocZrGJ5iOuj609J+
	 EHJl0GiO0z+InjRy3cZdNuMBFZck8h4IEv/Z7WF5HztSpzcXe2D87lzqjOC2Ehe7iq
	 P+STj6tLfJYsg==
Message-ID: <8dc03fdc36b72888bd1b59cec6feebad.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240506-th1520-clk-v3-2-085a18a23a7f@tenstorrent.com>
References: <20240506-th1520-clk-v3-0-085a18a23a7f@tenstorrent.com> <20240506-th1520-clk-v3-2-085a18a23a7f@tenstorrent.com>
Subject: Re: [PATCH RFC v3 2/7] dt-bindings: clock: Document T-Head TH1520 AP_SUBSYS controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
To: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Drew Fustini <dfustini@tenstorrent.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Yangtao Li <frank.li@vivo.com>
Date: Thu, 09 May 2024 15:13:42 -0700
User-Agent: alot/0.10

Quoting Drew Fustini (2024-05-06 21:55:15)
> diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.=
yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> new file mode 100644
> index 000000000000..d7e665c1534a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/thead,th1520-clk-ap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD TH1520 AP sub-system clock controller
> +
> +description: |
> +  The T-HEAD TH1520 AP sub-system clock controller configures the
> +  CPU, DPU, GMAC and TEE PLLs.
> +
> +  SoC reference manual
> +  https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH=
1520%20System%20User%20Manual.pdf
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +  - Wei Fu <wefu@redhat.com>
> +  - Drew Fustini <dfustini@tenstorrent.com>
> +
> +properties:
> +  compatible:
> +    const: thead,th1520-clk-ap
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: main oscillator (24MHz)
> +
> +  clock-names:
> +    items:
> +      - const: osc

I recommend dropping clock-names so that you don't rely on anything
besides the cell index when describing clk_parent_data.

> +
> +  "#clock-cells":
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/thead,th1520-clk-ap.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names

If you can't drop it at least make it optional.

