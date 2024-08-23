Return-Path: <linux-kernel+bounces-298211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458BB95C3DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E40B21ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043373987B;
	Fri, 23 Aug 2024 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Yudc/LsS"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BC1D52D;
	Fri, 23 Aug 2024 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384922; cv=none; b=fdhfpLS9xpRvS3KeuNdUEZkWAxAwtD43ILJQCXe6jdv0F8Tbt7FVHWMSHLsP/mZdS+X0Xdw604wo2BBm8N9nM07pRd9SN+3t4T4mu3THGPNaJG4QXdDSphNG7Wsh5pu7UqlbyOqbIZeOrFF/AHnovL/Ze6ddIOmQyVp/hTVWKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384922; c=relaxed/simple;
	bh=HylyApJyg4JL1L5hVi+TFnWcJzs7KwqcqQeYXRx6J+4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lUebEN1HbScISjOpf+MOXw1cuPtZtmJnjUmemSTz4LAGbT8eLJ2USDrmlbFCYocdWzW4u9Rg5yWvrm5yTPg6LyrEF0RawOHQBSePDwat6GQcxil0sYjRDEGhsBk9PAplGeIltnMLzDjnLLGJm5QjhA4ht59yBEe1nLwXAJbDczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Yudc/LsS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724384911;
	bh=FgeSrOHv+6Rg2NrAXC8HchICekN4thq7/uEj3KORuwA=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Yudc/LsSAh/NAZaSmQ1cwwN5piR03p1AgXpyYkmHbMVL3t1hxemDYV93fa3yP077+
	 HLZlEHBgNYJLs7CpY2JbPKKJhmLrO2gedIqPUoPU/U073AkLXd7B2hXKALfBGzQh3Y
	 1nDiRmTmNKCF41Ubfr1UPcsLT9IWvBZD7HQNoEauahsxIVRyMHzt4zpCIJ5RoBDBJo
	 fAsKG+VuslKwSXtBVxQKBi4JWhIn1JbzYukO+C0jsQsfFSxXENV0Iy5fsWrBHb91ew
	 ORjx/6Z1aTP4UdpyNVy9ZHXZT0XHXG32OGAx7TxqEQd5kx495St/SEQmzUcTywwIo5
	 rxr2Oyz1UdgyA==
Received: from [192.168.68.112] (ppp118-210-185-99.adl-adc-lon-bras34.tpg.internode.on.net [118.210.185.99])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 46CE564FDE;
	Fri, 23 Aug 2024 11:48:27 +0800 (AWST)
Message-ID: <ce983ad163263ad32e4291f3a7f9361e395fd70e.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: i2c: aspeed: drop redundant multi-master
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Brendan Higgins
 <brendan.higgins@linux.dev>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Joel Stanley <joel@jms.id.au>, Andi Shyti
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rayn
 Chen <rayn_chen@aspeedtech.com>, linux-i2c@vger.kernel.org,
 openbmc@lists.ozlabs.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Aug 2024 13:18:26 +0930
In-Reply-To: <20240822132708.51884-1-krzysztof.kozlowski@linaro.org>
References: <20240822132708.51884-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 15:27 +0200, Krzysztof Kozlowski wrote:
> 'multi-master' property is defined by core i2c-controller schema in
> dtschema package, so binding which references it and has
> unevaluatedProperties:false, does not need to mention it.  It is
> completely redundant here.
>=20
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

