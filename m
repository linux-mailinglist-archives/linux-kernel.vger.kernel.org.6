Return-Path: <linux-kernel+bounces-281056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC994D279
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4825C1C211ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9E198824;
	Fri,  9 Aug 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="B+g44/2n"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85A197A97;
	Fri,  9 Aug 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214928; cv=pass; b=ldDdH1jMecz9db3LIW+ry9EA9uE7fVBItPNdfhnquRatvPLXqCxD1UElxqy3YTjFsZwrSAzPpEs2sQ1s8V0gurqvUgqrepcLfwxJQlPqviwFEdSzjysir7AEqQK8ZUxPrdRKyBMf6hG/qhNol32lBNfzbVwtB2PV4Qf5BXPHvSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214928; c=relaxed/simple;
	bh=n3jU2cXSJSF0+sHFmSrJrdQff2D1Jr+2hVr3QXZAYLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxELperPO20n7bl+4fk/EfaP9L41ptr5CX2SAZ5xp7DXzIS9hW6NxB77hDHQV6Y0lRruTZRi/XM2bAP1pf+nxo4KI4ZDcjVtKscx+6tNXCTdRzv4fG9Jh2juXJoWDIFZGh5ZHCpPikzlsKJxnPG9shVdZwNJ1iCUS0SJnN5Efag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=B+g44/2n; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723214903; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iPZRKEGdOtPl2vFf7qI42JcU4h9P4WAjC7y4lhvoajZ5vNx6lGqoBzUSE+lHdxLbdMnK4ZpclZqG2M+I1HaVSuzqHF0Zob+hBxsUaJk11CwPZ7i7IT/LpJpYCvd8jNYS6a8fguh/qeSFogOYfVe9rArcdCqyKEJ0jEDoQ45RRaI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723214903; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=smDZAwH7Xg7hIGHU7tELbbraIzo2Ddg1qiPAtMCx6W8=; 
	b=PH2Q+Jm2PD5bjNScsKp3sCFGWQok544KMw/jvPLOaRg8Frj+YyUchkxvEOWbM4PTXVwpIGgKduOqLRXTWwVpuQufDfIHWZQ6dCjn+bF8a5DGuUbejgzJDQKvaWDkvWwvhR8BcSL+gHhDTM84TgpHyCMdIYWyCsp4raH2fqiDIOQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723214903;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=smDZAwH7Xg7hIGHU7tELbbraIzo2Ddg1qiPAtMCx6W8=;
	b=B+g44/2nnRJT1x8bqIF84etQJoODssmbWraQSIzLAV16/Lm9lD6tS54VUmj97i1s
	48md2uslUKNnlysB3wrDeNrumolpvxkVIcC3EsGcdO9VCWjbEPAmS9AP3aWwXm41G1O
	RWpFMiQUEtxL+4eJ3ViP/8GYJwsC5f5/wEPbJX1Y=
Received: by mx.zohomail.com with SMTPS id 1723214902621403.82223962907415;
	Fri, 9 Aug 2024 07:48:22 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: Add rk3576 reset definitions
Date: Fri, 09 Aug 2024 10:49:42 -0400
Message-ID: <8409208.T7Z3S40VBb@trenzalore>
In-Reply-To: <20240809-linoleum-ogle-ace67939d9a0@spud>
References:
 <20240809125553.3889-1-detlev.casanova@collabora.com>
 <20240809125553.3889-2-detlev.casanova@collabora.com>
 <20240809-linoleum-ogle-ace67939d9a0@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Friday, 9 August 2024 10:15:12 EDT Conor Dooley wrote:
> On Fri, Aug 09, 2024 at 08:54:52AM -0400, Detlev Casanova wrote:
> > Add reset ID defines for rk3576.
> > 
> > Compared to the downstream bindings this uses continous gapless
> > reset IDs starting at 1 instead of register offsets as IDs, as
> > introduced in the RK3588 bindings.
> > Thus all numbers are different between upstream and downstream,
> > but names are kept exactly the same.
> > 
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> 
> IMO squash this with the other binding patch.

Yes, I wanted to but the issue is with the subject line: do I use "dt-
bindings: reset+clock: [...]" in the squashed commit ? 



