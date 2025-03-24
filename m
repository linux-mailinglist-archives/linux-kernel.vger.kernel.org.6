Return-Path: <linux-kernel+bounces-573536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D3A6D8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F271891E98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0A1A317E;
	Mon, 24 Mar 2025 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="mb56Tlnp"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B682C80
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814092; cv=none; b=egUNOfshU1ZaEGtRMKLj5PnCuS9QnXeHRWu+em9RqsXS4QA2TEEQVdrI3BnEFrBIDcNnMXhWSCCf37dAikQxniKcQpbfT4n+g+qg85ESUiHPLQOHqugUDuUCMfk6KgmNZnd7ajAl/BiAzhIHNZII3RIWVyQYcu067iQhLdI4+ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814092; c=relaxed/simple;
	bh=fNcJg85jb8uy9BPEHwY/03BnrTApgjljAhujB76L3OQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=L14woXVdFPYwJ6+oFiYvkNfby2asw61hvUPnoMEQ573IGFui+fZ+wfUHZmjSeU3Ix3Rg85u13/FI6eZJY/uXi4e/ZaA9KRBiIXRI/ZpOTCsI4w1x0fut9Cn7bLbkzoQ1SRwcejtvQ1e4zhROwuJXxs58wNcNHRBm4iYRGXkCZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=mb56Tlnp; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1742814078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fNcJg85jb8uy9BPEHwY/03BnrTApgjljAhujB76L3OQ=;
	b=mb56TlnpQ2C7KhQEa60Jci1EhHvGjef7HtEcDICRX1TD0r4ooU1qaLVYYQfo8ZkzrnjA6W
	hOXNmmclCAYps//MT6KIy1u3rRLz+++/Arlt8PHXLtrsH43IRK3fRXdeiuB4/DGailAm0W
	Og7X5LJ7Bl7RxBw7USIAe8iEwYPaQAsWiIinnHBcwZ1XG31KEJRDXHAdiuY18+/F8IoMcx
	ov/J2tLfPc8xY6I9sj48SWZwXB51DK9VGy7qtt6NltNAakWwKys9H071NSvnKJcCTfs/B3
	R51GnMEODCmGELfdr8t02ff/sN22pU/zixEqsrC0a72BAF+FjmUSdt4EETa+vA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Mar 2025 11:00:47 +0000
Message-Id: <D8OG0OI3HO2V.326AQZHJWCBAI@postmarketos.org>
Subject: Re: [PATCH v5 2/2] arm64: dts: amlogic: add support for
 xiaomi-aquaman/Mi TV Stick
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 "Artur Weber" <aweber.kernel@gmail.com>, "Karl Chan"
 <exxxxkc@getgoogleoff.me>, "Christian Hewitt" <christianshewitt@gmail.com>
To: <neil.armstrong@linaro.org>, "Kevin Hilman" <khilman@baylibre.com>,
 "Jerome Brunet" <jbrunet@baylibre.com>, "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <linux-amlogic@lists.infradead.org>
References: <20250319190150.31529-2-funderscore@postmarketos.org>
 <20250319190150.31529-4-funderscore@postmarketos.org>
 <f36875c5-73bb-4bf8-a59f-5df30043bbbe@linaro.org>
In-Reply-To: <f36875c5-73bb-4bf8-a59f-5df30043bbbe@linaro.org>
X-Migadu-Flow: FLOW_OUT

On Mon Mar 24, 2025 at 7:02 AM UTC, Neil Armstrong wrote:
> I get:
> Error: arch/arm64/boot/dts/amlogic/meson-gxl-s805y-xiaomi-aquaman.dts:243=
.1-2 syntax error
> FATAL ERROR: Unable to parse input tree

Yes, somehow a ";" is missing.

>
> whil building, could you fix that ?
>
> Neil


