Return-Path: <linux-kernel+bounces-310983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 128BC968392
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9301F2365D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28C1D2F55;
	Mon,  2 Sep 2024 09:48:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF3187338
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270518; cv=none; b=SDr6Mcq1FGjywJHBLwaB2wW9zOhH15LQaHrew2AnfzsvXnB0hZxeHQg0BgLEbt+RYlHuy6hIZDeks/HRus4FYyWzff7vcsXy6pkkQrv9GD3Ik18Z4dKOjk4jLvCowFyfuVacuRCUjhjPeiz4nTpjFriMmY4GgQX+BeNtBgLDe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270518; c=relaxed/simple;
	bh=C7TfomP8USzw0OjgG7IH6E6QwC38gv5ltK3BAu0GsVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUCk3i1cvMZjITkJNTDvNP+j/qxK3LSYum9dO0coRoHFUkKfxZoH9lkl9CkxxkHIbQ68kPf6IBeB7kUjSH9Q9oq/u9C6mvmkHASix/6x9UfWoZqZp1db6KPiCaXmmrldmecM5wkQDWdYCSRH4n5CdGZcQ1G17yoUTD7qlLTBLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3fe-0000aB-Lk; Mon, 02 Sep 2024 11:48:26 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3fd-004s4q-Bm; Mon, 02 Sep 2024 11:48:25 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3fd-000fwm-0w;
	Mon, 02 Sep 2024 11:48:25 +0200
Message-ID: <9a7cedb13a3c24185f241df88bf56ddd1612137a.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: socionext,uniphier-glue-reset: add
 top-level constraints
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Krzysztof Kozlowski
	 <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Sep 2024 11:48:25 +0200
In-Reply-To: <9fcb9c03-080d-4798-8173-a24c7d05b420@socionext.com>
References: <20240818172819.121697-1-krzysztof.kozlowski@linaro.org>
	 <9fcb9c03-080d-4798-8173-a24c7d05b420@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2024-08-21 at 19:31 +0900, Kunihiko Hayashi wrote:
> On 2024/08/19 2:28, Krzysztof Kozlowski wrote:
> > Properties with variable number of items per each device are expected t=
o
> > have widest constraints in top-level "properties:" block and further
> > customized (narrowed) in "if:then:".  Add missing top-level constraints
> > for clock-names and reset-names.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[...]
> Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>=20
> I'd appreciate if it could be applied in devicetree or reset.

Thank you, applied to reset/next.

regards
Philipp

