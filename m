Return-Path: <linux-kernel+bounces-390973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE3E9B80BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26A228126C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67B61BD4E2;
	Thu, 31 Oct 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hnviXS6x"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6C1A0B00
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393992; cv=none; b=Fii7oYD+Mt/nAprvfUbDpcIxLwOFhNrVem+twysXo2kWqWBN3aCgpvQemwKXJ0ZcPRkFHaPsimCc54GL9I4gQh9TVDNQSEGSJboWz8H+x6rZju2ZgxFX7ywvMinxMS0O9NBdXOBn+4iUVaIBR1juGOFGCwMnvyX1E61jVwrf7Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393992; c=relaxed/simple;
	bh=/afysMSaENRQwC76hvuh31Wxpq/F6BxBQjYCfPst+SI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hTqKRZ8J1P8btxwS25p4krKS9YXIHRogeYRNGVyGiP3i0prRsPp2a803fizuBBfB1cad9uvPUIM3zq13z3xeUB/2IjgAS7aDhFh8uAASkM+XQfuZs+a9FFjNQdMVd3R4iPXSvqRF9BL7Ohv+kIWd9m1ctG3+mUxBUQCCGYRDYj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hnviXS6x; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730393944; x=1730998744; i=markus.elfring@web.de;
	bh=zihZv8JaQyeTBRL3c7USYyTDomdye18v6SbgC8QVntg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hnviXS6xzHpHhUG4/l4SRYILsdkpux1c8gUwVr3gOOy6iUEOE38Lr+o1l0aGwsQk
	 Kf6UwC7aOhVfhsgdLCSUYYQmXf9iNaHOUCFo7vkvZK9tzzAmZXEjbEWhqAyrgU/4j
	 IKib+g6uwDRll8tr07p1t9cHJaLqz2mCHKYziwAp5tZDbD+/yQuU3beei77Pfrcem
	 20HH/ftYDDHZBgA/Vi5TyS7BfOobGK4JTPtqL1yK/JLHy1gzfJKwL8KOsDBVtKgOk
	 DLenkIj/mxB5UyeULs7bOFFEEYaEp3TAduas/uhLHfMarGqVwhwI0GTtaxgPw5x0e
	 R4747KoKgE5OzVpOgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRk0k-1tH2tG3Yb4-00MOig; Thu, 31
 Oct 2024 17:59:04 +0100
Message-ID: <56f80d5d-3b92-466c-adf6-5f1374cf9622@web.de>
Date: Thu, 31 Oct 2024 17:59:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-phy@lists.infradead.org,
 Colin Foster <colin.foster@in-advantage.com>,
 "David S. Miller" <davem@davemloft.net>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Thierry Reding
 <treding@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241031123847.1356808-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH] phy: ocelot-serdes: Fix IS_ERR vs NULL bug in
 serdes_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241031123847.1356808-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9h3N7nZodewEH5ksgQ5nVq7VnUGJyxQ6DWBT09YUdvHV1dYoQQk
 HFXFpf6pp7mwboNN0B8oWSJLvOxT4E95VFMqonrJlyeNNNbWbHgj+vtesaW6l9lwh5XNGg4
 JVzJdZiBI1Dk7ajqkupCQaZagw4kwPyZc2Nl2MC13dYpB62MLWo8Jax04Nj3vi4PmBNGXw5
 6wM130MIg7MCAEjhaIkew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pQK5qY5zieM=;SZNDGVx9Zjqtqdt3zeYkTsXQx/3
 WrzWXy1jDhiKXb9CgRGdoM7jx5h/QqVICjkO1AfpNsRh0TlCMOyV+GQV5Yc9GwGrDaetG205N
 VptfiRf4NwzpODS2J1sGLCF/9Ibs8WF8V7B8D1TpdWGgq9zzz9fd074tW/HfHIq6kuqcPaNdz
 mazvmexfZJsi+pE9b8mABGqDf4oAsFxL2kJ3SSNPx8tq9/abc7Re8fyWb1XcsYyjni/TZ4Ebz
 e4qwWG/FnsEgkcsOuqgoMeMgLWJZrO00u3VPEOxGgkY+NEF/hDQK/VuYTWdfX6pMEK/NHuWqE
 QsJ9B9KAVYFDVqPe9BIL3VwS59Z0zyBrUI8zcIsIwtUNjTKUWXq7qfyLFl2KFgfrgUiZLM2K3
 0UT4+GtwB9+PVQWCzXDDgXZYj31HzEG1Mkhxt9VzfWGNzL2u2ED/CpBSNPQ59oI8+niiZWWLj
 xGTvE+BdmQTiNSb8LBCsfEopoqLDyKiFK0ch7BQ4BZenFjCJ4iEcz+R1r7fIoOzpl57qOqD4L
 ULxhUAFR+hTe4N8SZHh5rHr0VJeVAg5isZXXF9Wb3K3F50roxjf57AE3fnw0RNtEzi5krJlSR
 34y7SZfDrEswl5Ta2CYZ5qyHSXwJBVxqhU37KHgYLMGx50F4bZ4wadMzL1kA/xcINtXF6h2Rj
 TwVoNNCYI/cm+jfR2DKZFB8/Q6vdW7dgc/n0nrVdate3vhsU57hiCgoXhwMdacyD7peNcYsw1
 yXfUzhFgW4ME4c0SGhBSkgbLy22FfiY9rEqetFttA0r52YvLcz4+5VSkKcOaB/piaMhBJYdOn
 qAQw9YZVzsr0Ek2V3Ru5GiEQ==

> dev_get_regmap() return NULL and never return ERR_PTR().

                   call can return a null pointer.
It will not return error pointers.


> check NULL to fix it.

Thus apply a null pointer check instead.


Regards,
Markus

