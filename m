Return-Path: <linux-kernel+bounces-325781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A3A975E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA440B2301C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6F263CB;
	Thu, 12 Sep 2024 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PW33KAQW"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17338F45;
	Thu, 12 Sep 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102338; cv=none; b=Q5LrLWauYv8yWX5U+xjNgo2I3EVUCUvYwg1iMhTvkvGfj0wAcvTeJ1Waf+kb/WQ2A1bvPL24NQaFIK2uuojYuksoO+QrZnj9WNpHWsObmDNzGaKd6AENbtkXmKk5kZ25NQsubnnvo4/Gi7bVfR7/+qzHpHNvCKlLFCidVZYb980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102338; c=relaxed/simple;
	bh=2VQngztHRnEp+3r2CybqohuxIQlCmejfmOOnUHXAJkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hSoREu/2IzXgT4KLjRO+MDzFDn42lxiRHBrOIkI/f5qJqWjIC6z75AMCXg3p1Im1YZpAnxGHinfBoq9iQ3K7PziVioDyBmnEMRDz4ddE+60dErFVpQibKOvAFI0DqQS7uceWvQpSryYFRUtO20RVXhp8XZJ8hrQAJ7yX5jR3Qwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PW33KAQW; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726101986;
	bh=2VQngztHRnEp+3r2CybqohuxIQlCmejfmOOnUHXAJkE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PW33KAQW7ezqXTkUJELheZI99O6C5LbwAW3+2CvLfMDQM7kuDWNsuBK42JvjEo0At
	 AMFs2orEnMf58pl3Z2S8BeQh5Svk7zvXHCpjMUKN+rZ6LA+XWXiBorbe17BwMtLDxl
	 IS4SEwVwmIb65LmAkM/ZySu1BPmlAEQAUv3dU1x2oDYxNPRjb69a19XjIsV07AE8I6
	 leKBCjVdj7zl9qDGbTwmJidNNE2eewIFZvUCBZvPrG+LevXoVRQx2qamgltpbXIVEA
	 IkV8kU4LIaGELgylbCN2ygVXvb+Q39816H7O47OwKatGxkxF0O8780GsDlpLvJwTu4
	 GHI3Mv2tU90OQ==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1EC5D650AD;
	Thu, 12 Sep 2024 08:46:23 +0800 (AWST)
Message-ID: <082cea8c7ca1aa15001b7c48b1c3ef1f209cc40a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Fix at24 EEPROM node names
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 10:16:23 +0930
In-Reply-To: <20240910215929.823913-1-robh@kernel.org>
References: <20240910215929.823913-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-10 at 16:59 -0500, Rob Herring (Arm) wrote:
> at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks, I've applied this to be picked up through the BMC tree.

Andrew

