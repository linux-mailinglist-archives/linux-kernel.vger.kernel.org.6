Return-Path: <linux-kernel+bounces-182179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D308C87D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499081F24F11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69D5CDF2;
	Fri, 17 May 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QtcX2HJH"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF86A039;
	Fri, 17 May 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955519; cv=none; b=XVEsbi0zh90cr1ZNxzidPbZz2Ke/OajeXQFJhSwpForzQ5OHEX847nhFLIPhQ8yzJErm9cmEgO8WfuN4bW/HJyk50GCqQiFFe3OhA1Uq2a2eiXwWGipUGdL1VjaI1ygitCnY/dDUHcu3/AD9qJZALy9CImz12H9ccM+vuj8sQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955519; c=relaxed/simple;
	bh=0MyMW8f2yRiwRYOL0mM92snyp6FS/EYPmtOXgJsGijQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=crOrc49y/MqKUH6jTYkHJSsU3wXg95ECoSNYOd6ieIWJahewZFilBz9XrNyCUIpcNKxqwjeVr2LHI+MZjqtTY07CyAqGvww4lKJVKAtF59T41LGAggyLB80+Z1mVq1KKMoTUVohf/12c3gJsRKF6rRqP68qVveqGueFzbR9N7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QtcX2HJH; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715955491; x=1716560291; i=markus.elfring@web.de;
	bh=MwR8LNQW+IMvspEyi0NBIl4LSDNfg/OLDJRvmnbFCoA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QtcX2HJHV2KmujFtpsgapQ65G+rGFP9J4ToVT89CzDXBiZiOs7cAWs+QGt7n+j8P
	 nOd5mewiZV19AUgb7iiEQpO2qiweI5sMDqM5aZZY48nTJNHDLEPXV0b7DE0OhOpkF
	 1RQUZf2kLmvg1S1Uk67l+cHS2ONB/46RGK8ZTLJnhE8GQ75sd7gfGv8c85zPvmLny
	 MLD4Vk6QRd6bLuVnvJJw0wmF5AWr6d4i5o1/pLLwzjOWpL/k3rHuCuoEvEa1YPCGQ
	 qrbgWj7geSMR01mp6vcWtEP/X7E4SgnBWtf2AqH3L6eDwCe4ElvAGlrkqZFzb3bRY
	 37HpYSTIEhYST3YmZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVGC-1sP5cX0fH0-015rih; Fri, 17
 May 2024 16:18:11 +0200
Message-ID: <1d470a85-dd92-44d6-9900-db4c581b68c4@web.de>
Date: Fri, 17 May 2024 16:18:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Dan Carpenter <error27@gmail.com>
References: <20240514092656.3462832-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240514092656.3462832-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uoqGK2Tqhp1g9qS8V6PXvJShn/edR8b0iG4aBWJ0nSzYKCsBBw3
 TDQO5fJP6GObkdfkU6MRPbJ+MI5ysZnP5svtFTg3ShY5Ogk5p5hH9wL84NgiBORdbXyy65a
 J67YrwG3yvMVYkRnm3B+nwQD4iW3gevx4yOH39Is5xETu2ez92obeL6coU0Ln4Q95G19XtZ
 dR/N/ZPqatSL3eD4mbSMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r7kbR0dVTzg=;uXbK75gC63Hvf2FC2E7M99KA3uF
 Trf1ixyVNxqsSUXKLqrl1cdpd40u9DvlH+Zk7vVOFqLDY6hcAv9om7vhkDB2N2YvfvmNXCkH9
 nwyAQ8+CmaBG2+pSAGTcWmrjB0kSi64ZJmqMpdd1M/fjwNuOVN4EQ1nYcenLFw4QS76f9EB8m
 sc0JHaSA/GB+YcMx5EwO0f0+HUn6skSx4/pxO8kuYZB38wThvIoJq5r4tELQR6Sr0WBV2hI6C
 c6dIwGPeHa7GjkiuLEOZ+wNoiV2e22e3BkEEUPVGnPRZ56hu8m4Hl1yBAesPvJ7UvU889ByUy
 Nm5dY8G2PIhmrQmorhN1CMIIoV9JjCGxyOUc6YLeIJEEGkmAsQpuBavAj9np/MAIGdiylD3Ka
 JM3S2mlpw3mokFQnUj+uctXnns8xyOvp7Xwva+0/VkkE7SuBbd2NllCgzvw04ziyjHzkKqj7R
 ZE8JjvOhdSqRSdYy3pw6W3b4nln3MnTgPmrG6IvndZYUxJuprUQhYZ3AZet8JXQYESOgS5JxN
 dEuMlp+7+GLASUY7KM8713ox7SramMifOaf6yqTcKZoSSHXIMvQ0qPAV8rq9yqKMTelRT0Ci5
 Hz6oIRiC+D5LWsk5faTSqrhZN1fbqHgmBCwfLuyZ0+J4tL8/udrJefVGI1IMWzx2TW939l0t3
 kbVbbjANOVqE7G7OonP4ar+gO9ff+iSkVazwOAK9F4mlpmelP9PttZ/sVkP6C/r3u6Y3La73e
 BobdJD0ENqi3zRf4cZxsoL1WVCRiokMd37tYd5gMpV4xhgaMga1VbCsfKOE7VWEk6V0c6vSSM
 hge1d6mtd0IsQn+OWUQMvItT/mMylAR3NyqmIV9PnjBMU=

> In tpmi_sst_dev_remove(), tpmi_sst is dereferenced after being freed. Fix this by reordering the kfree() post the dereference.

I suggest to take preferred line lengths better into account
also for such a change description.
Thus the second sentence should be put into a subsequent line.
How do you think about the following wording approach?

   Move a kfree() call behind an assignment statement in the affected if branch.

Regards,
Markus

