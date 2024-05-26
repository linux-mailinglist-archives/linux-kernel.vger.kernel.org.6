Return-Path: <linux-kernel+bounces-189599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA948CF2B3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 08:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0821C2095D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 06:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D38821;
	Sun, 26 May 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h1kWEPQE"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1E63A5;
	Sun, 26 May 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716706151; cv=none; b=UD5QvqiBLB0BaJTqtYhAesTOqwwd9SdHNINYmxeDsMV32aZmwvicQlXMORHUx6IIiiywBONalKHveghFU13mIB39wPNpD0qmxJr1x6N6X1w9mRd7LIILJzcrHMSdbzAgfw/kc+PwOgimOoBzanSHUvIzO3bVeVmuXM3Kn82+z8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716706151; c=relaxed/simple;
	bh=OiHjt0siDQqvGY8VnV+rHZQiQTcvyc3EyCZa+CupTjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lvxj9/jTCEv/eh9s9+Q0dN/TGnZsSNM/XAgQqXTB5PVEPBhkYWC62L3JCr8F/ywwnJTVvyzi97V/Ia+IMVRL1Kt6/6JY9vmtyb7xhMXio6qAiBsCsigIdVUkGZo1jGxeAEVDCgevbJUQvefLcMSTBy0l1rFEt2mgBWMWo0GbA7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h1kWEPQE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716706143; x=1717310943; i=markus.elfring@web.de;
	bh=OiHjt0siDQqvGY8VnV+rHZQiQTcvyc3EyCZa+CupTjc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h1kWEPQEiHR5KbRXzsiVZ/RU99yGOvPUQziWgiJiYSHGnh3fKwn5fbjil2E/5U+h
	 +DmAjOUdShyUY7DzegvIU9r9YKFKlX+SLYEipv/HB/hW93ZQDePqoEqF12d0AbNmm
	 BWmergP8tPBaHO2OYFeCuDTlZFv3ClIrSHWFSkz83tIFVvK4/mCmgBT6LHNL+xj/G
	 2NRugboxd3xxSEKdJCh6WjLF0D5K+eOK4RWS+DLYtZjddtxc7fuS/eT8FRA08RbBi
	 VqyfXa7kwgLwIO1Edn/+eDtQG5cSKjLHr3ceGDXQ148F9utwb9N/amCpa4DFjDwMe
	 mim4QZqxRsP0uIDDNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZMD-1s4kp40jRh-00LqcC; Sun, 26
 May 2024 08:49:03 +0200
Message-ID: <79ba60d2-357a-45f0-93af-78879b9f4b02@web.de>
Date: Sun, 26 May 2024 08:49:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] usb-storage: alauda: Check whether the media is
 initialized
To: Shichao Lai <shichaorai@gmail.com>, usb-storage@lists.one-eyed-alien.net,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
 Xingwei Lee <xrivendell7@gmail.com>, Yue Sun <samsun1006219@gmail.com>
References: <20240526012745.2852061-1-shichaorai@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240526012745.2852061-1-shichaorai@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OXoA+aME6lnNAQSWdIumGtUQ+qNtxO4D83yhqvkNyUne1qneMsd
 cGdDBzuwsNW6I/xTqrtrINfSLrO1z0QmXpwKnaEC25OIxbrkJkG/Y+rHnoSZauTXrqJvCfe
 bHFd5Sfzi7HlomS0eGt6IQqbIh5vG+k1ztRIGb1kpCz4CUSMbpDa1JYvl3z8wmVZFKLch1H
 EQpOEpku0Q3ddQY1CZqNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jGCwj6I+3Oo=;8eY2ZJ+x+r/9GB0D0lp9OfZ83KV
 c1LauGbB0wPyH4rfhzKiQn3QE5P8w0Rt00iSJmxur6FfxDJRWOELwGaGmuUPiWWglf1J00t/X
 hclDKTCgo2IjmcIDKiL9QpyxZ7dN6PRjOJR02zt16Ti+SlW2CA7yAgvivifktmG3zVO+V5lDR
 Nvo0PLF3tlDYt493U3sPmaJB4Ccas/fakO2cOSyikhiqDdQ8B8O+iFSqtssAPLlflVDEa3Sc0
 ie1cCpmxleNGYBitjTfL+Xy+d95d8E4mxAZHxrEvpXscjvezr4B0YL5mIGPcmDSkaVbD0jQTo
 6r/RPLUbbaTcve/1p5yQbT/UnIb/RTBYKyh9WU8Tr8RioC26p+D/b4WmmAcmjXKOvza6O8a8P
 bs+ntkewDMIfEN4ImjhzmLOn+99/Uov4NZUU4K1pk0aGujvuTjLTzSCKx/rInPsOYOqI3f9SZ
 XSP0kGrVSUebVyqbWXKL9Al7uV+7hldiVZz3oS7KuuqwGrQqKTpv9ilVjjK718oPGHFoeDj+8
 Hr6SFfZ2f/4WdiWlZ8acXrd66jcTNyd0WCCYLGBIcg/fUJlsWR0371PWJ6+y/PW8knopYH/i3
 1wmILOOo/IUgsgNtGiwRNCEAFiUZhCN9+CKNz27Yjc+2bD6ICXuOSWoN/V+CpCQKFZyRycIlH
 b+sQlWS6/o1k01o9k5SPIVVC/GnL9uT9sudUYemEQEhMKP6OGHE6i2AHJoFVAyfxjx4A3PP/H
 P9ucS04ANoB0CWwf9ABcOLf0x0A1ILYOgzWcQaKAB8FvdSJzjyGL7V3AjDj0wYs6w8RrqB57/
 QU6s9mE7qS45lt5/QlOz0LqYEysdh2iZ2TVN3SVX0j4gE=

=E2=80=A6
> Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")

How do you think about to omit the text =E2=80=9C[PATCH] =E2=80=9D from th=
e tag summary?


> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>

Would you like to add any links as background information for these report=
s?

Regards,
Markus

