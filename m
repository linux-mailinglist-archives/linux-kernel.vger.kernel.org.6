Return-Path: <linux-kernel+bounces-537424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0ACA48BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F06188C31F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDF1E1DF3;
	Thu, 27 Feb 2025 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/hNhaWA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485AB2777F6;
	Thu, 27 Feb 2025 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695543; cv=none; b=mqjZ5KdNhbtPUFREiy0+TWhwMdu7QTQLP74B53LAPR061tLATSXXhT5UGwURIVi/y5TgACx+5JpBR7svwuqjz0SMHmcBMuiFajS0MQzMxCUuHmDi1lOXiyP0cQWEtwBYCCm8EHUFGUMJZATIBmzR4b9IEmQiccOzeyLSosLjK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695543; c=relaxed/simple;
	bh=k6e8ofzrBt9aHKWkZMG3dJtLmoBrQbP6qnALTS2lQdI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=M7JGoHa32q4HWEcb0V70enhKs/un2lgKaXbYaui8thhdnmL+AHClheZyBfvIjyriLMagZUs/dvb9DAojGK/RYoAXrvvmBZTS3b8wIlOTdIWKY3PcKqQTbBqc7dC7W1g+TZu5uYgmMHNFr/bRe8FSaMfmzFt1VxH+r4mXfwiySmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/hNhaWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161D5C4CEDD;
	Thu, 27 Feb 2025 22:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740695543;
	bh=k6e8ofzrBt9aHKWkZMG3dJtLmoBrQbP6qnALTS2lQdI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=H/hNhaWAVRKKe3XZoM8aE+Jxa6aolkEyh1d6I4j1+iH+3E9HGKKLb9LdoFcJatXsL
	 eDcqBLfAPj5Z6OWNkystoQ0BqtnVavVl7/masmi+87CnxdmkDfggsT3gIdmexq8jvX
	 S19uIXKOBnZzJQTOya790x0e7iKBTnrYoIDuSYij2rUoGvPeuWX4KnBTtJdyi8Gzy9
	 bn5ZM9IVamjZ9/1wIPh6jCP8QlCm/I1Ppb//1UNOaIzJ4xPVHqXORoM1LIIP2tU5bJ
	 N43UcaPi1aKd4kcATSus3TbDuEEmxi2YauzUK4xpZ1Hr1GOcDZHOXpIaTdZsNrw+zp
	 cGktaOohkmQ3Q==
Message-ID: <14dcbc0a6000aa43feda3681a3ad7548.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250221075058.14180-2-friday.yang@mediatek.com>
References: <20250221075058.14180-1-friday.yang@mediatek.com> <20250221075058.14180-2-friday.yang@mediatek.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: mediatek: Add SMI LARBs reset for MT8188
From: Stephen Boyd <sboyd@kernel.org>
Cc: Friday Yang <friday.yang@mediatek.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Friday Yang <friday.yang@mediatek.com>, Garmin Chang <garmin.chang@mediatek.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Yong Wu <yong.wu@mediatek.com>
Date: Thu, 27 Feb 2025 14:32:21 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Friday Yang (2025-02-20 23:50:53)
> On the MediaTek platform, some SMI LARBs are directly connected to
> the SMI Common, while others are connected to the SMI Sub-Common,
> which in turn is connected to the SMI Common. The hardware block
> diagram can be described as follows.
>=20
>              SMI-Common(Smart Multimedia Interface Common)
>                  |
>          +----------------+------------------+

Applied to clk-next

