Return-Path: <linux-kernel+bounces-199915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7698FA7C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA911F23C78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E213D511;
	Tue,  4 Jun 2024 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="N+2j7c4p"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E44A04;
	Tue,  4 Jun 2024 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466037; cv=none; b=AvYfqCJHXvbXn4ARYLCG5mgI2yb3Rb8GUs344OjQIZjJ/g0I2Jq4NYp/gmvvcn42u6h2MVJHUs0UtWflnsI4NdsHRnMH6SFVvalO6qzorJLotkW1zVtS3ZV6C4/FeyzLvWnxN9b1h3Lu6YYCCR9IolIH2UYb8ovIEr9151IurP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466037; c=relaxed/simple;
	bh=8Myg52lLWrLZOLkXAsnAEtMJuwErLEP/S/CM0D8BeoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4WS4PN6i+AU0Z8XaptjIK8okjczejiscQmzYuC4LkJsirZxCFYXW838xgZG4sL+NHb5g38WdhWWKGIB4pTpl2qufhuaXLabTdojTUdmY3NnRGGvtSEhH5SIp1HP21QaELEv6VfzN3rt0s9doI55BkP6XKVISRXqWZ0YFky5kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=N+2j7c4p; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-171-248.adl-adc-lon-bras34.tpg.internode.on.net [118.210.171.248])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 56C412013B;
	Tue,  4 Jun 2024 09:53:51 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717466033;
	bh=8Myg52lLWrLZOLkXAsnAEtMJuwErLEP/S/CM0D8BeoI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N+2j7c4pxg+RU3Ui5pOQmzKgoMYWUFKHKG3B7qXpkU9UWks8sRBiil4hs5fn0W+4f
	 sBVA5EixdQawh0U4DWtncxYLquPSpBT4a12DwB0w5vgFeiidPfcJD6jdTwvVs/hQ0Q
	 K3bu0pvugMEJoUdc3dmieC/uRvvWanFdFd7DkbHT+JT4pYx2+Bt3rVK1aoJHZAWSax
	 2ZLzkCYRMNxzCZxq/LkuZr8Ta2gdHfN707jRuIfVnuj7v044T9SVnaRnyyhA11+bOz
	 9LjNi54m5R2rVeebzxiH92jeTXqH3/92lZ/SOocCc6uFoOSoMOnjangCmJZ1WnzZfu
	 DSjkFIgGgefWg==
Message-ID: <9375ace675ef1a6bfb00c916c940fb839ed10289.camel@codeconstruct.com.au>
Subject: Re: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 04 Jun 2024 11:23:48 +0930
In-Reply-To: <20240531193115.3814887-1-robh@kernel.org>
References: <20240531193115.3814887-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 14:31 -0500, Rob Herring (Arm) wrote:
> The standard node name for I2C buses is 'i2c'.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks, I've applied this a tree for Joel to pick up.

Andrew

