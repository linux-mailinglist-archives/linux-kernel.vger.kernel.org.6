Return-Path: <linux-kernel+bounces-323906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33949744F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122C51C2560F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9661AB50B;
	Tue, 10 Sep 2024 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ud1eKVQ8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C5176FCF;
	Tue, 10 Sep 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004250; cv=none; b=BSJas++KgYu0cEbJNcdgHkeHcndjMKXu1574LCoTVFswnYiCGpxxDLi29RvWSSFKb1kgwIXSg4OkeFp0Ao+a71cxLiqIWrnDgIDJc9uTSYmXnckcGWiBC0RO2btfeantXG3RY1u9T38fJ/058oPZUby74jVSZi1W0HJQ3SIGukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004250; c=relaxed/simple;
	bh=idPe0XPtIh/WisXlLQ3eyyv4S0wgAHzKGd6g0+aysK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZTiISXrC7Hz6KjmaHY9cbNZ260lTeqUcB3wUeKPG1/LDUJ94YJb3seOdmNSRQmG9RR024Fp2HR7S2Yy+3D270hPDdyI/3A2BH51yfMP/Sg7IEh6JH6EVQKcxScehPIFAlqlfhV5h5eeWIjt0H5hI7JeLKQ0uABTvi17ftnNdOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ud1eKVQ8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8238B4188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726004248; bh=kLQrJzCDpokRIdK1XrBZXANiLj4CRiePYhe+E2VVHsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ud1eKVQ8fNb19e7Tp74UYAl6d/8YOR8GJKN7zIVkRJIbfg4TqFEBpBlbJKAN58M7K
	 ZiztGZCf/9GBi+gic0KAxoNf8wq2WSMMYMNLdPOdHpoyR3Pornk4RnYLaCVZ3W1l6m
	 HpRBzx+qhC9XjBTV9yDT8QtgYfKB6xMrUYGt4qZnVRnCWGpkeJi7dAYftsVM8LZF4f
	 /O6FjyNYPPsWt58U3UqQTNdxiBUVNbvw/Ml9IC9sxgM7Jxy5NPnTWi05CPSTJ6dbnX
	 YHZpRKN2hURrWYlQlnj6P0hxrZ+CPDLFFIBEh5s5a5RrzsfCne6O5R/3YHg9uR6edB
	 WLd8xBLyjC4fg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8238B4188E;
	Tue, 10 Sep 2024 21:37:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dennis Lam <dennis.lamerice@gmail.com>
Cc: Dennis Lam <dennis.lamerice@gmail.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes
In-Reply-To: <20240906195400.39949-1-dennis.lamerice@gmail.com>
References: <20240906195400.39949-1-dennis.lamerice@gmail.com>
Date: Tue, 10 Sep 2024 15:37:27 -0600
Message-ID: <87wmjj5gx4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dennis Lam <dennis.lamerice@gmail.com> writes:

> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
> ---
>  Documentation/filesystems/journalling.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

P.S. For extra credit, you can go back and get rid of all the :c:func:
usage... :)

