Return-Path: <linux-kernel+bounces-520547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1086CA3AB57
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026AF3AF26B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9271D618A;
	Tue, 18 Feb 2025 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld4zujNy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EA286297;
	Tue, 18 Feb 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915466; cv=none; b=ehPOiPcVU5oLsRQ1Uebilvx9ARF8DyuXcVVd8YY5Iz8Olz04VP/7G9H85sY0rdjtfxi0wicXqMf+QnXgfKyBKqxeLVzdL/62E+9P08BmJhTmHNQ5Pu3fZSVzbOLbyuJiEfqp6O5zWheoorWHrcqeGpUrl0nziKdnvOucwTHN0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915466; c=relaxed/simple;
	bh=9e3XyBz54l22mh0Z3FsfCVrraHqX7Xy0MXFHgJzUHyk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=RFDxcKDohphJTc3INW50/jWvbC818EAHGHliZg0WvLxrGXZ++DM0QUsEQMbxRRpo0WVnm15fJyFTCvqSO2cppwXtq4X2Im99R5uAX+O0UIb0qhmoKG/4HZRJ9qhs71w3Th2qbvgaubkfoR824gizDp+YkZt7CEZCfJhzb+wa1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld4zujNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BCAC4CEE2;
	Tue, 18 Feb 2025 21:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739915465;
	bh=9e3XyBz54l22mh0Z3FsfCVrraHqX7Xy0MXFHgJzUHyk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ld4zujNyZaTn0X+NtO1cF13Gc8hagFAAIuoEnmIlBmzXumpc2CjzlfSVJl9ZzOj8m
	 GTIemwv4b4O86mmintNBA02I/sASkaNyr62sD1Cu8UZpJK4qa3Ylbq+ioKNVJeeqSI
	 lUxWHl+dgsBOIPCHxInnbMeO0wypIb5lQDX1OgLSgVmmgMJUjFWpAEdbj6I0op+Xrk
	 bM1ueQNOSemSICC9p1e55Kuj4aoWqINKMFrFCqcza+nviFYkIv+YA9K2MkenHt+9Re
	 XcshSTxMHL/xxpfNfQb0PtVCYnMiC+oGtNaKtukrwiTGxKNe3eE1CwRId02VvQhQiY
	 1Ne7lc9V9IqhA==
Message-ID: <c68c14422c7d27278f6fc75f285db7c7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250217-b4-k230-clk-v4-1-5a95a3458691@zohomail.com>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com> <20250217-b4-k230-clk-v4-1-5a95a3458691@zohomail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: Add bindings for Canaan K230 clock controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>, Troy Mitchell <TroyMitchell988@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Xukai Wang <kingxukai@zohomail.com>
Date: Tue, 18 Feb 2025 13:51:03 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Xukai Wang (2025-02-17 06:45:16)
> diff --git a/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml=
 b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..d7220fa30e4699a68fa5279c0=
4abc63c1905fa4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/canaan,k230-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Canaan Kendryte K230 Clock
> +
> +maintainers:
> +  - Xukai Wang <kingxukai@zohomail.com>

Is this missing a description of the device?

> +
> +properties:
> +  compatible:
> +    const: canaan,k230-clk
> +
> +  reg:
> +    items:
> +      - description: PLL control registers.
> +      - description: Sysclk control registers.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@91102000 {
> +        compatible =3D "canaan,k230-clk";
> +        reg =3D <0x91102000 0x1000>,

Is there a reason why the PLL range comes first? What's at 0x91101000?
More clk hardware?

> +              <0x91100000 0x1000>;
> +        clocks =3D <&osc24m>;
> +        #clock-cells =3D <1>;
> +    };

