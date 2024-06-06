Return-Path: <linux-kernel+bounces-203497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D818FDC1E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51C0B22A67
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A211078F;
	Thu,  6 Jun 2024 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="IU0jUGdO"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3158BE8;
	Thu,  6 Jun 2024 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717636992; cv=none; b=ZePbnAbVX1y5wrfh5c083/njrSM85YqVG0RLxIERwJDoODl/eKj2YHrvllQvM+aFx27NXnwMmst+v6eDAY7CDjO7ylDrSIQuR+1AueD1P+lbpsWPMS4bBvn9fjiGUnHEVOVxKaHgAwYpF5q3eK1B5jYXzXLERqYWSSlSw/Tgg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717636992; c=relaxed/simple;
	bh=UjCQkvI4M26je9HMZzMsWZBh+I8xIGggZ70FgnVDcQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKabkV6pe4eXDUYDLkRT9OUWWdS0hbWGJC3w56bBVjEEc/eJtuXO/X5V4Hljepy93zwUqeu6NamGl9p2DDNVAdMbg7ggmqffK46HEhZSEjOB+7B8VWE+FW2GuNK49Ij5GW8kGFgu1u3MiTlqIxrMkV1gwxBf3SqfUR7WHY+WnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=IU0jUGdO; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-171-248.adl-adc-lon-bras34.tpg.internode.on.net [118.210.171.248])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D323820154;
	Thu,  6 Jun 2024 09:23:06 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717636988;
	bh=UjCQkvI4M26je9HMZzMsWZBh+I8xIGggZ70FgnVDcQc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IU0jUGdOLenpD5F3uv+BbB0xNmgwD9pDNkrGQLceE8Ldb66Gq1wG/pbcllTuMpFDt
	 jhHjXkTsVGb8alZKkTLPcTzXLFMoN+y+PI/SUV7t9VwKgD92UjacWT/kH0x/aEJDK3
	 RvJiGbUactTxrRhTLRIdM6jgvKenN2TQf9FzK0GsJoU6XLEtVfzgeZLfzigoc8WZFi
	 abArJYOQMkiknuOGYoj94Wh3t2eZo4b1WGWlC7t5b37zjnP7+K9e8IZEO8MPukbHJr
	 lQLl1pWX6lUxNS5xbF1aNfiJ2E7rHRNTWodaGwDqaxB8b1tv+DpitRWjWuTqDpowKn
	 +X7H1mKKf9smQ==
Message-ID: <4faf9b73f1d896b5c65c1934c6f6b95051b49b31.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: System1: Updates to BMC board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Eddie James <eajames@linux.ibm.com>, Ninad Palsule
 <ninad@linux.ibm.com>,  robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 06 Jun 2024 10:53:06 +0930
In-Reply-To: <4c0eddbf-5397-490c-8c70-a581c7949b49@linux.ibm.com>
References: <20240605160604.2135840-1-ninad@linux.ibm.com>
	 <4c0eddbf-5397-490c-8c70-a581c7949b49@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 11:29 -0500, Eddie James wrote:
> On 6/5/24 11:06, Ninad Palsule wrote:
> > - Changed temperature sensor monitor chip from tmp423 to tmp432
>=20
>=20
> Reviewed-by: Eddie James <eajames@linux.ibm.com>

Thanks, I've applied this to a tree for Joel to pick up.

Andrew


