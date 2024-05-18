Return-Path: <linux-kernel+bounces-182921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4C48C91BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5322824BB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5712D47F7F;
	Sat, 18 May 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WhZLLQUG"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3206523D;
	Sat, 18 May 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716053478; cv=none; b=Y2NK6iRiZh98LtgrPt/zZv7V1/XGzI37sEj3ecVPZC1M/gmAGWDL4jroDT0qrFMDirSzT7MoYvtSOHxpiQSCnYKe5emrbygyLN79i3zmNoFxefqCZsZKGPO1fqXB6fpOtTPOGFJUwQJasKTjS6P89jdudnlwQMEabIEVj2QRctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716053478; c=relaxed/simple;
	bh=2O1miVT/XdPJihc2p7u6IVNMBH44PACXdBxKaONkQJQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Q+WrOgpDEa0d5IJO6n1ojwtiJ4YWTW4nsUI8gl9XTjRzZU5b7zKUqNWzZSImkjl/uR03O/qgF5UtSxjcUkpb4k4LC41V0VfqTiIbNWmXb2FojgainXMIAeP/Jpxvs/veDZqsfkc6S6qQF/VZwrQXv5GSP8KHV56IWT/q2qXkDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WhZLLQUG; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716053455; x=1716658255; i=markus.elfring@web.de;
	bh=eL4hjgQlJMPcDPrPSHtb6xEr5P5bjeF8euR52SltdNI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WhZLLQUGXaPVoCXSnthEKRaLu83Cyv2AFWYayatMQyjMnGc62y9qGhGHp9T6SoJF
	 qFL86Jp3+VB+Gs+B8BrzLvBUX4mzwn6B21btfig6J9/uSaNGyoUf9ICCD9xbd0g9T
	 /kJ9bUIonaS6zVoL+BWFLoOsVF22cQnXcBdQjqJsCtuvKEUuAqETxUGrJI+ydQ3Pv
	 1z9O+MgX5SDRDbqj0KsM6o4U5rFNCl91k01+HRQFqFV0stdGZZ4vfEjAmmw8YTWr8
	 dfJA1sAx3Q66EsBI/r+O6uougAind5tvMJHgQUgObCdZ3ZZ8LjN7cxXvI8rLCL7NL
	 ApPM0V+TCSomHM9puw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MftC1-1sjwZT43mD-00qfNx; Sat, 18
 May 2024 19:30:55 +0200
Message-ID: <d5203ff5-8ed4-48ea-8e58-a2e6680b0542@web.de>
Date: Sat, 18 May 2024 19:30:52 +0200
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
References: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rnBboJFir9DtIyAcFr96chGI/SWtCrTRevdQBvM2Et6HCRy5at4
 jlzD1pKQuJOKJ3+hYrehCC2mfaI8BRWG22hZNaebPz3L+ATBDLrlXEWWx9q5upL000jjbVm
 8aqQnC92yS1oyOkyGy0u0kbFnkOPL27aLhd84l7KFoHht+wRJ4Gk2p7mTrMD31QIBEnuAVg
 lHWZHNbK2YrySI6kRoAOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DfBb7UC+ayw=;bDrtiI4iaWO6Kmt6J5roTCey+6w
 ktRlRw0eJ2WSYQMap0AIOQp5EZTSXGwEV1Q0gR1uI2TXkLL+L6fMlLTAuJ3tMV+EwVsnJs+Cg
 y5ppDUxQ7HJC6EErT+b5vkiceI+tgZWAN3CPQGh+jpfcgchcKsvYzvhtiMikA3ZNElX1+KLzN
 xjpp27fOlhp3+DK6PuOBA+xwY+4UiNisaXxDERuS9f6oyFqP75jREXS3kTi5Rvq8Pdr4Ef5Zw
 61cVLQus0PCulVP/Xqfs86pKLueX6rIB4cbOqC/HBYh0NEVE5G+PkYzN9JM+oYPzyzOtOzawW
 cfmdVd/qZ/4wizmsLKMny6pn3Y4WzDvzODELTZp0XAo5feScx3iVPqXJL2aG13EzaGWHsnhl7
 Y1II3buUY4C76Sr0h2PeorxFRFvGaOtumNfo5F3ERrD4l7sdxA7Yv40JBPvw59fgW1cJcuXhe
 Osmhj7AWNP/kQMeVmIXpv+/YtmV4N902ESjAUILoIgp7n9qVURDFggs+N6Ao4Swn8imP0sJfW
 JZqlzSfl1VDL2xFd04U9PGAyt250igD8EsLlqGa8mxluQmUOV3skmyUX7CKdCKDGnyAwkpW+o
 lNcljx6k1BapQAoSybAL4ZZXnxzn4Xffi9UrEyAv6W9TAQ+ow3OfOXAhy03b3aWPLwBi+cfdx
 GGsrMuzcGnhlyFjlHkk2qKzjTcBUqAntSxwpoiRHkw+V4DRSKtd30VEr2891LcJI0ycZqt6qx
 aHUznkuSYzCBo3pLqUbNqXwhecPcxYDUgnWK9BbNAzLTcRbgmxOAorKKC/6hJXxaHjz1YyMDv
 OEM5GeoMGVPB2phmRohynMMFuLoNSFJb0Avrls6Ym7yeo=

=E2=80=A6
> Fix this by reordering the kfree() post the dereference.

Would a wording approach (like the following) be a bit nicer?

   Move a kfree() call behind an assignment statement in the affected if b=
ranch.


=E2=80=A6
> ---
> v1->v2: Add R.B from Hans and fix commit message wrapping to 75 chars.
> This is found by smatch and only compile tested.

* Can it occasionally be nicer to use an enumeration also for
  version descriptions?

* Is it helpful to separate additional comments by blank lines?


> ---
>  drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-

How do you think about to omit a repeated marker line here?

Regards,
Markus

