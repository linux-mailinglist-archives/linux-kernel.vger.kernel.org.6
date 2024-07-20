Return-Path: <linux-kernel+bounces-257812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5226D937F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19C31F21A90
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26DA14A90;
	Sat, 20 Jul 2024 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LQX8MGY8"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D3D51C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721456624; cv=none; b=kqLMkHVp6FbrT/AMWZzyE5gVIStfqAV1KJC0YjxuDsj8B7wmAbSvh0lOLwfKeR6Xrr+jknQl03q5TZ5aB9TZPfkwVhGLPuQDmxf7ypkuqP029cUvqdi8ZHFT9f8cD4sJykkbFOXKST3mRhx9ffkO5sDKlYqUAc3Xckl/RchApcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721456624; c=relaxed/simple;
	bh=RqhUFzx0R0DJTBuTrGUN47Du1aedUUH+nlpRyBEUV4E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=m16NQ4YN2rSBTcDxhPRzDoQ8ukDGLQGldbpO5KkvaDEJIGM4sa22qSwSPzCb5fr8ZqVRqm8O+fqc5Ptd2GEYQvBcAGsFiTb/3Xq02iQ2hEBTqJsw1NLqHZMOM6SaN2NoLBheBxeaV4KgCn+MEwJxWP//+kInWhYdpmKJ5LphHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LQX8MGY8; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721456599; x=1722061399; i=markus.elfring@web.de;
	bh=UpSvj01b19X5A/DIUDVFYuoBfOsri08u957KIo0j9bQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LQX8MGY8nDELeCsfAlLlJ30/bxlh6YRa2WuVM6DxL/kpLoQkYIIO70wLGzKleJJN
	 /AR048UnNAFyQgfwo8ww31cnYXtcwoe4K4SY5X0PDzLYreWyXAxBkntoKcTotxCPM
	 p3ie/O4cC54Xpb6RWgKh31Osh1n0k8CukhmvlQkchOugmHRdYQhX6/U11w6CDBrp2
	 5WABPd3BGOBROeDOtn3Cm3/cV27BYMQuU592vG6a2W6xhuHAKVsxnTBGUO/RWpMIG
	 EU20OJBdtRdvvMhalXu0lnkud7DLvWz1/1+3zXeCL4dcKgr064QS6+ARHqxZ4YxSm
	 acv06IqyMSTgtZyLSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M76bb-1sOiN61sDf-00Bjr1; Sat, 20
 Jul 2024 08:23:19 +0200
Message-ID: <87db1a67-ede6-4da5-89b9-a75a67770edd@web.de>
Date: Sat, 20 Jul 2024 08:23:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: George Yang <George.Yang@amd.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Min Ma <min.ma@amd.com>, Narendra Gutta
 <VenkataNarendraKumar.Gutta@amd.com>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20240719175128.2257677-2-lizhi.hou@amd.com>
Subject: Re: [PATCH 01/10] accel/amdxdna: Add a new driver for AMD AI Engine
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240719175128.2257677-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zknNjj64JrPzCZ9PYSi5tKcntdHJfVxeMZ0wDiU5fUX5IAwdCfA
 3REEX20OTKUls5BUUTM+vu+SdU+Y7o08f4NN6f/pzD1KBmhffvXo5Cka8yhYtXFxQREF//A
 rQtRyFGjBp3YYaPkKTaBbbnW3vmLRmTVIJASCJE8satSSFQTgorOY3zHbgeJ1FOU011XnS7
 Ez4hw4cUn7CRB3lt+dM8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tOyPzbQ6Sjc=;sM5sJ5awRw1TpQT0gQlvUM6N+vD
 RTev1gg32T8iqkqUGwj4GbsxebpODAfIghdxd07fIxsRRxe8HC11e5kujTbOTT2Pfmyy5vP1W
 FW3Oy/bs0Qw+dv5lKIDCxcKPFz8IbE+FumVMFg49pMZjPia+AoqEsYR+eq+He9MysOQVcJO59
 5Vc+lREQUIrtlvOOd2HPqSg16+vR7TXogK/rx47jB9XsCV9F9eAbNdrU4BVBokgxx6tilt/ov
 2nmHTX+2x4zDZzA6kkOA0hF3K8rTlYCOy3//UYHQhR3YaCLm+uGHV5lnxeZviZ7r9KvqPssuA
 QJGoqOplqmAqgcpxcavQC+w+NwNxF5g8GQg1HXOpNdWCFjmMHQU3j9tsfbo7WdMad+kjNxSyA
 HEcizX5ShNz3MQSF6qN4uzyiLi75k1K8WadOX/WpZeDH33h4BeI4U5dHAe85WHdMj+TqYcroI
 0W1/91s+slsXAret6xoIgCUn/+5by767eia/M+FvvzaAE8IbWfsZlWYqucnC3013ZhwUhS1ZL
 ApZR5Q0BX09mnDX6zroU8ygcbhYnDl55TKpKVpBcUCgwEhBZzzMQoxNis54i9MnVcLUTZEora
 BogKwi/FdTL3xs+nEYWO7v8LP1TkvlTtudhyhnrSqGyDQWsQ2CdW38XUT6dIWa1eZYt0QmnbR
 vc9n2wCSwYTLEPHnLWz1BDE11SuqmBo+N2KITy063DzGgcRFs0N3QMYNaBDaVmXajyc/IlM14
 YqFOHZnrIXHP85xoybbcYrtw75bko+RDP4v0PCjeszHUztU1IAvYnBAC8Nhvkvk3YvUK31zvu
 VSt7dWaP6iZb7InBUv5syxPQ==

=E2=80=A6
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -0,0 +1,182 @@
=E2=80=A6
> +static int aie2_init(struct amdxdna_dev *xdna)
> +{
=E2=80=A6
> +	const struct firmware *fw;

I suggest to take another software design option better into account
also according to the application of scope-based resource management.

* You may reduce the scope of such a local variable.

* How do you think about to use the attribute =E2=80=9C__free(firmware)=E2=
=80=9D?
  https://elixir.bootlin.com/linux/v6.10/source/include/linux/firmware.h#L=
202

=E2=80=A6
> +	ret =3D request_firmware(&fw, ndev->priv->fw_path, &pdev->dev);
=E2=80=A6


Regards,
Markus

