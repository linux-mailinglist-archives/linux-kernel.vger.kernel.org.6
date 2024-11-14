Return-Path: <linux-kernel+bounces-409930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584CF9C9387
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5542824F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002761AE01C;
	Thu, 14 Nov 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSxljZa1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAB18DF89;
	Thu, 14 Nov 2024 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617649; cv=none; b=bJbhJZ/8DoXaWYRfutP8RRYtNcyq68FtJ6Dh3qMcspDTGAKYjViJ9XEnlgv4UfGGvHVO5q/JcNHOg24LsRPRvBQBG/ZONUTSD65QHYdVJyrDcogE3dZouUrgeJqUJs7tuEjLohKixElwRhML7yqK9BAVN0Bgi88EediFLZR7i7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617649; c=relaxed/simple;
	bh=ESt7B0hIxd1hLIVW0eUcxPEDQNtVKZOVOyMn6TkpMyI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=N7KFUE58Jg0o4yv1+8N+Tk7/BFOdHVhf85uX+i+9KS0SogZ++0xgzzVeReg4u4AXXs2mOQnweJZaIyk2ef3PosKUG7sfnVi+AbvhPRayLrZEsjCPrmAo1iTADrIUWMb5K8BktmwteEDUmEH/LiFokAaI/1XyIr+vmb/RSVqmRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSxljZa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F2AC4CECD;
	Thu, 14 Nov 2024 20:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731617648;
	bh=ESt7B0hIxd1hLIVW0eUcxPEDQNtVKZOVOyMn6TkpMyI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=JSxljZa1jdN9RcYVX67Q3CyiIjQMq0fupvVPR9XDJK0NnBOm1HmW1WwhDa0t+MzX7
	 2nwnhwMuYYC64gBFcFaE0SX6W74ZSlOA1+kguGXNUhB707EQ0BFGUEvFL5jfojIqRu
	 CkeZUDSg/BvItq6vVSn1vSeVkjBkjET9sAwB2nd8unsGnKs6jsnYULGzj5lxgbYqUh
	 q9oOcm/nflw7y3PexST4LP7XDlZ19eYxgsUBqSeJn8nTW8aoKfM9cGd6uIexQq+wrF
	 3tmL15Awb96qE2WR7+WCyPsI04WXOa5CRzvUsPGXU90qdmcgjhfKt/As/vSNXsWrCm
	 tW+eYDB25X3+g==
Message-ID: <7088d73b2dacb174319015e7df2ec399.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241106111402.200940-2-y.oudjana@protonmail.com>
References: <20241106111402.200940-1-y.oudjana@protonmail.com> <20241106111402.200940-2-y.oudjana@protonmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek: Add bindings for MT6735 syscon clock and reset controllers
From: Stephen Boyd <sboyd@kernel.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sam Shih <sam.shih@mediatek.com>, Yassine Oudjana <y.oudjana@protonmail.com>
Date: Thu, 14 Nov 2024 12:54:06 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Yassine Oudjana (2024-11-06 03:14:30)
> Add device tree bindings for syscon clock and reset controllers (IMGSYS,
> MFGCFG, VDECSYS and VENCSYS).
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-next

