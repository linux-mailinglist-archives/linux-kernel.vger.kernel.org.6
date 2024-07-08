Return-Path: <linux-kernel+bounces-244785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EEF92A987
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDBA2814E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699014D28A;
	Mon,  8 Jul 2024 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S56rDTsv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297A1474AF;
	Mon,  8 Jul 2024 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465323; cv=none; b=BdgiZ/aJXIbivpKa5tje9R39klOkUIo5P9upQeMPVEMxJlUZhbAa0JxnRUGDUnm0zg0moSrkyx5kEE0q2hMq6sqdMXq+woNyvEZfZdBRFiB0XrPpi1qlUivxMpAjaQDf+GOKjTFNdK5XBImqvcjnH3QQo6QtKrcz7CI5OMxA2wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465323; c=relaxed/simple;
	bh=zNv3CdsAy7qnE1vDIXu/jgdGKJhS4oc7HIXXOYD1i14=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=g8KE26JiYrzpvEQnpWzE8HbHG8PmM3o/T6jaKspSxCOJDlmoZqtkdV4/3xDqNHNYXZYGZsEt9dLpd4coWHST7y90KwLsaV51NZW3eEcgrZ1kQqlSjgwSDCozfs1jACPXSRpXkd4Bw5GrqBWf2pjqI+ObH8wrCz5Qh1783LdT+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S56rDTsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4F0C116B1;
	Mon,  8 Jul 2024 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720465323;
	bh=zNv3CdsAy7qnE1vDIXu/jgdGKJhS4oc7HIXXOYD1i14=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=S56rDTsvxnKU7hnenU0RfZ6yBrZu1MiLkuj/HIuSoKmmEfa777Ht9t7yuBjdCx4rP
	 IXB4s0EmoFbxiHQeCdwfCe1seXuq7KoCCkbNTd0hnI/tGPTjvr8OmJYEf0TaS27fSh
	 x9PuhP0IkbJEaopUjYx8rgi+/UZpqn+hr9hrTape9fgilQbv2oeI3sqybxE9dVHB5D
	 cAdIzvkreDQJFoQ8ajU3cpUzuXQK36PnQG3d3XOrtMOFQ4y8gnRDi9p6GOu39qRM7x
	 +XYcumJhfJwOvDEoopzga59lOgu64Rlt/WFI5L7txvQ71C5URoPtSqaUPAN3ugJJhz
	 u3hdCrTPd5+aw==
Message-ID: <977bf1136272701662ca7bd8b0a38319.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240628105542.5456-2-ansuelsmth@gmail.com>
References: <20240628105542.5456-1-ansuelsmth@gmail.com> <20240628105542.5456-2-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: clock: mediatek: add syscon compatible for mt7622 pciesys
From: Stephen Boyd <sboyd@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Christian Marangi <ansuelsmth@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date: Mon, 08 Jul 2024 12:02:00 -0700
User-Agent: alot/0.10

Quoting Christian Marangi (2024-06-28 03:55:41)
> Add required syscon compatible for mt7622 pciesys. This is required for
> SATA interface as the regs are shared.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Applied to clk-next

