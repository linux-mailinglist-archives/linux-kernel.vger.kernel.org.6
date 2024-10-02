Return-Path: <linux-kernel+bounces-346911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7FD98CAF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B61C226D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C4723AD;
	Wed,  2 Oct 2024 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UYtMhb9s"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA97F9;
	Wed,  2 Oct 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833547; cv=none; b=q+3RgS0oLVVSQiwMHL7TVW3xBDnFDlIYxH6FjfrVh0sJUhrUPN5eoN69uMKQq8COojG4oaW+qSaGaXTUgr2Hlk8KuOVTaSS3uN17Rt19ZASJOv5HeAmO3NN7xBAb6vqdd8mQe5exti89dqshKgIjwpK7U0myQU9NLcjfIx5TBXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833547; c=relaxed/simple;
	bh=h6hDxQtvLGT++p+WhFFHHCGOItfXEFrbkqWTcpqFG7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzcbDjCB9rI9zd0RGdHWqaaeGT5/T6HGdVSL66o3ko1Dbj5mfbVGMlYcBEYNpL7MyhY3BmKk6uKqYtk64gh5OgHUiqyS/pzxHecR+aOeNsmgcc9tAlIIni9IH4oBhYJP+Au6m3QAk4sPD4RUnJobZ5hXSMsB+hQMPeHbhLJ08D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UYtMhb9s; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727833543;
	bh=h6hDxQtvLGT++p+WhFFHHCGOItfXEFrbkqWTcpqFG7k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UYtMhb9s60nVVl28DuukmvFsrCNEXLegHT2d6PNUQbFSx5CYO947pifBZDDp5BPea
	 fL4tqqYK6LyvMFUB6GdELZ1+rs7b/CDWVeWL1Q0qczxvhRw4ahQOz479AQ4TYY+Cl7
	 1NOC8FwGJ43Sx4ND1kOaSP/fqpVRM1kIdhBpst2NtiYJVh7oAn2JDT2+uOqI17BPTG
	 6lWb+svK2AUq+Ah2R5mzd2oC0z1c4NpdqjhkBhyLnnF/9dDfJ0So5iUAz5L0iphi9W
	 u0/j97+lQ9/2hdtc85KkbNNe+/OUNm4F7KkluDTLo8AyGdCtlly7RNRRBpqsWI7rJt
	 5meLKIX1mDfKw==
Received: from [192.168.68.112] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D0DD865013;
	Wed,  2 Oct 2024 09:45:40 +0800 (AWST)
Message-ID: <21415012dec630193b916900f1382d5518d98042.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 07/10] ARM: dts: aspeed: yosemite4: correct the
 compatible string for max31790
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 02 Oct 2024 11:15:40 +0930
In-Reply-To: <20241001082053.3455836-8-Delphine_CC_Chiu@wiwynn.com>
References: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
	 <20241001082053.3455836-8-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-01 at 16:20 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Fix the compatible string for max31790 to match the binding document.
>=20
> Fixes: 2b8d94f4b4a4 ("ARM: dts: aspeed: yosemite4: add Facebook Yosemite =
4 BMC")

Can you please order this change to patch 06/10? That way the fixes tag
is meaningful. Otherwise the fix is disrupted by the code motion in
06/10.

Andrew

