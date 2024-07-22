Return-Path: <linux-kernel+bounces-259415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F519395A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8721C21861
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A94087C;
	Mon, 22 Jul 2024 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQqw+DMu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71931849;
	Mon, 22 Jul 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684753; cv=none; b=QHVH1UR98lS+kknTwroChauLxCv+qkX37vo+74u5NfzoVOM0BsB9jg8FTuJexYercgqWBQ17QWgw+b/xpB5pIaaanhTe0G3hq/wpPTMxpbTiFTs/gg5zEYZZt0ltU7Ye10NXZLlUQP1zN+nlaoOLplAasUGSQv0gIlK6zRkJ4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684753; c=relaxed/simple;
	bh=/xZgTSrW9AosvGMvfW8XBKjOE8TQflictgJmmzfb074=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=oGlhsaq1MZvYArvFGMxDAVTxSu1zO+TgF003RzaN/xNZmZMkyhuUQxaW89WQspRuQmuntMtKyJLwl2fw3fBnROM45mkzDnYJhHqwljZ4ZLQFKSTq6lXV9go/BpJMRBml3iEJSQTO3p3Y2WPBHq0DTaRKS56+dXrLYNWFfdZPl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQqw+DMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A0EC116B1;
	Mon, 22 Jul 2024 21:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721684752;
	bh=/xZgTSrW9AosvGMvfW8XBKjOE8TQflictgJmmzfb074=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=pQqw+DMudSEJYFHKP1KhBtPXCUESakiC00Merfyp9wKwGuCSzl7HQ10xqjbZTdbED
	 2vkySIwQyEXOnSjjCjcidQnEwyKcMkb9NGexT9hiYA4HXBEyytX/kNmft2KOp8EYBg
	 TFp35nfykzlrpqZ9ubtFxX6jfEu5jrJRwcuKhoH5oynBTPyUHVrcFjdTKBDIZWzwlh
	 l3RgWn/PQ0HDhJrcxe75g3ecNBUy6jt1VpfIHfGueRfmF3QyVRIJvmiOg+MNvhVMnW
	 j+qJ2l4F5K20cfEv2uk66gM0FwT6nldACqP4dfieXnrcCB+BPPe7X8vajhuLnIrZVp
	 2mfsVs9NAbDkA==
Message-ID: <8147ecaa95ad514a6d8c13662ada7cdc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240722094226.21602-9-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com> <20240722094226.21602-9-ysionneau@kalrayinc.com>
Subject: Re: [RFC PATCH v3 08/37] dt-bindings: Add binding for kalray,coolidge-dsu-clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Yann Sionneau <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org
Date: Mon, 22 Jul 2024 14:45:50 -0700
User-Agent: alot/0.10

Quoting ysionneau@kalrayinc.com (2024-07-22 02:41:19)
> From: Yann Sionneau <ysionneau@kalrayinc.com>
>=20
> Add binding for Kalray Coolidge DSU (Debug System Unit) clock.
>=20
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
>=20
> Notes:
>=20
> V2 -> V3: New patch
> ---
>  .../clock/kalray,coolidge-dsu-clock.yaml      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/kalray,coolid=
ge-dsu-clock.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-=
clock.yaml b/Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-cl=
ock.yaml
> new file mode 100644
> index 0000000000000..a7f6239b17c12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-clock.y=
aml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/kalray,coolidge-dsu-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray Coolidge DSU Clock

Nobody knows what DSU is here. Just spell it out and then put the
acronym:

	Debug System Unit (DSU)

> +
> +maintainers:
> +  - Jonathan Borne <jborne@kalrayinc.com>
> +  - Julian Vetter <jvetter@kalrayinc.com>
> +  - Yann Sionneau <ysionneau@kalrayinc.com>
> +
> +description: |
> +  DSU Clock is a free running counter that runs at Cluster clock frequen=
cy.
> +
> +properties:
> +  compatible:
> +    const: kalray,coolidge-dsu-clock
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dsu_clock@a44180 {
> +        compatible =3D "kalray,coolidge-dsu-clock";
> +        reg =3D <0x00 0xa44180 0x00 0x08>;

This looks like it's part of some bigger module, possible DSU in
general. Is that true? If so, please implement the binding for DSU
instead.

