Return-Path: <linux-kernel+bounces-275907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3AE948BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A3A1C212D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9911BD50D;
	Tue,  6 Aug 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b="jdsvpt3T"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1167165EE2;
	Tue,  6 Aug 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934566; cv=pass; b=Q6KiadvBowBhVvEWHs0vQmBX7M1gnkVV7V+HdpSZBgnpv51X7jEp4Rx7IMTmkdgho2c/6jnpGOnpiB/zRQ5Cym+O/I3My4stGJG5skUAFYrRWSSTJN8+gNgzYoFBNGR7tuJ+bOIrdKOm5Xr+BDa8GZ2VAba1S2+5wpmVQ2sxoJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934566; c=relaxed/simple;
	bh=0J+3XnrsOJYN/0H9QnemZt0E++HbNWXSEhx/JoMbSEc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ssyVpFYZOWjpXlQsk7EW1xexqy7S9W4TUyy1jJfwSb6zVUfzXhPCfQjs4k2BQA9VeNueKWU4jJvjnu0fb7g0JArDiXTcmoohXm3w4X8XkkNRymCBa6V0VBkgbz5z274jz09iPFl0AVDCbwI8AUfbDRVa3Br2vcSUhiIaxgLx1qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b=jdsvpt3T; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722934555; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IeG5P7wMxIGYIvJTYZo+GGRXPr9jU8JXhrRWlaR2GF+XkibIoOVzb06gGD7LZm/OeEVM0402bBn7dJdNguBPd8nYxdMLEvKas6U+GyERViCC4+pLGwq/vNTswAk7M4joHvtZxYUZkmd+hnUY2T2ZF3K8fJKL8S+hi//DGXpZCzs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722934555; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=46FGarQ+Gb6fnnbVjZJzhYqZv+IqQ+GP8N0sis3nVXc=; 
	b=feLypRvLUUm/SDmS9Q/S2s2AE6y0XAY1KH5TKGvA2MqJJoox7ftkrQsymWXnR7lIb/yJUu84pB3TmSMNJganiwFlIVwJOwi6sQUiiw74xOl5Ln1Nhc3o5pU45bL03xPFp07j54hUaDAWm0SP/AGOIQtSOKpZ0fdhGPUryDeQC3E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=angelogioacchino.delregno@collabora.com;
	dmarc=pass header.from=<angelogioacchino.delregno@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722934555;
	s=zohomail; d=collabora.com;
	i=angelogioacchino.delregno@collabora.com;
	h=From:From:To:To:Cc:Cc:In-Reply-To:References:Subject:Subject:Message-Id:Message-Id:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=46FGarQ+Gb6fnnbVjZJzhYqZv+IqQ+GP8N0sis3nVXc=;
	b=jdsvpt3TKDUcDAJwaVONSQF076JHenq3/e3x/urpn6+FfGIWyXPgJ9UfNksRslrf
	a0hZ+/KO5RuMvmW/Rl+l0NWxnb38ymyWOxFR/5nej/r5J4wZp8W/HqOGJ7AjH4Uj5QW
	9b8MU4YzZM1ymBio5f+ibg9Vs4xjuQZb+pqCW0ow=
Received: by mx.zohomail.com with SMTPS id 1722934552450742.4038831923073;
	Tue, 6 Aug 2024 01:55:52 -0700 (PDT)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: Rob Herring <robh@kernel.org>, 
 Kiwi Liu <kiwi.liu@mediatek.corp-partner.google.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20240805065051.3129354-1-treapking@chromium.org>
References: <20240805065051.3129354-1-treapking@chromium.org>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Remove clock from
 mfg_async power domain
Message-Id: <172293454965.67359.1861418696492290008.b4-ty@collabora.com>
Date: Tue, 06 Aug 2024 10:55:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-ZohoMailClient: External

On Mon, 05 Aug 2024 14:50:23 +0800, Pin-yen Lin wrote:
> This clock dependency introduced a mutual dependency between mfg_async
> power domain and mt8183-mfgcfg clock, and Mediatek has confirmed that
> this dependency is not needed. Remove this to avoid potential deadlock.
> 
> 

Applied to v6.11-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8183: Remove clock from mfg_async power domain
      commit: 8294c090a05d10fa17fc63ffdaa643f1d123addc

Cheers,
Angelo



