Return-Path: <linux-kernel+bounces-257919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313A9380D9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2867FB2130F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000E84A52;
	Sat, 20 Jul 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="D0zMPaip"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD63A1C4
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721472878; cv=none; b=CFIDrPdE8JKEn3X/YcNRuLdRiD1M5flL/14xeWfRvgt8gU/vduGW5dZKiqO7KS8HhPOZksvgePY76g1hvpIBBQOedd0ClkOOb/7rVaJxdXA0c3uX/iZUKeK9XHJKOazy4TBloTb2Kq4oMzY+ML38E/5NE+3jqLYpq94AXuPWs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721472878; c=relaxed/simple;
	bh=E8arWo145SuSYBQPemHj6U/99DI7Umv2Yq21Ciuz8PQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GRm+b3Nvs4/rWbX5Z/0tGBhFzzpWTBZvvNuAzoazjUfYhQCg6WroBz4KK/9yXIxe75ECZP1lGN8U40ymwhY8qojEAvLUr4ixU5qeiYeWRwIIhwlgpcVN9FlMK0iQfwOwS4/lk09mRyqYLtzvmKAPE/S9KYmxrsN/znr0p8HgTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=D0zMPaip; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721472863; x=1722077663; i=markus.elfring@web.de;
	bh=LLEhJPZ8SLB0+bsCDNdkC9BeNWaXtWQXE9YFyqU9VuI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D0zMPaip2szZdTDXMNUvO/IEm1fHWtPNFQmCrYGiTRXpEISKwL5i5XH+BhxAS9hh
	 OtWUfKsJHkAT8gcIrXS7UiyIRBV/RvrrF37jwko4EWs+MELtBsp863EAf/tZQNOFD
	 Cjcy7pW4gWH+AUwreeb8nw05jrZ0eccxqGqERRnGABPWeP34Ame1jdHjswo8y6dum
	 IILMrXMJm2bBgOJ7DhqPPhmBrQ++ce/UbOho4n329mxdKYjp902wWohKrJdm+LyPl
	 FeShDNd6bSDd03JKuwA/oqbZlHwFEgDkHp1X2Y0POlmlaMovumbIuAupDg9DasD44
	 yJYjCS+lRwmlUibDwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ZeA-1sRno3238e-007H1y; Sat, 20
 Jul 2024 12:54:23 +0200
Message-ID: <d24462fb-b9ed-4212-8008-eefaeed8c04b@web.de>
Date: Sat, 20 Jul 2024 12:54:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <min.ma@amd.com>,
 dri-devel@lists.freedesktop.org, Oded Gabbay <ogabbay@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20240719175128.2257677-5-lizhi.hou@amd.com>
Subject: Re: [PATCH 04/10] accel/amdxdna: Add hardware context
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240719175128.2257677-5-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Qvu7N9mqbZ+7MOHRKsnrWm6syiCHat32dCp491ZdAcbLPFw71A
 5gXjnfaghIMF93PZA04jC0JbrUDxegLfmwzcr7+rlVQa1XA3LfExnBOru5/xzaGwxrPnMxV
 ZCsanys11yTE3VSBb74IYj6q/ZpSiYqf+ZHJXbET+xHf/aDcH01uelePhb95ND0JHtjE0CB
 TJdY/2CBnLSIBaX9k0WOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2gud571q15A=;VYijdEyoIaP3YQog6sa3FSOQVcA
 nNIg85vBDZOxhcJtHo/W0u1Drb9lytoxzLpOy8OBmHKCQxn/JvoaDT6HYMKl2W5As3J+hhmcN
 Cr0tixmHoZ//udx9iobZKYzfWsFO+FaYgz9qy1adJ78Na0BxjUaM8kAUFM5UXucLF8dDZeOP/
 pG2nMHhy2uy7I2sMUayg8ZAzP7ixaVbPXTA2ZyE3jMlB5oTCYPRevN8/g7OIoWD7fI2gP/GAQ
 F6y9uF8l/+ewe7fEmsh0wo7YJ9LH0kET+QiiaaKjS1pJec8dH+O4JnfT92E7VWoHYb88I4HEa
 jDcyZKR1c0X3bsgNazNKn+b/LOqsro8jSynTHrFcTaYJPI6qsoA3BMyeEHCH7yZs8AH7F9YFI
 qenja7oy/mB2WUU82XoMFGs1VCIwkmCkLD/lC4B0SXESDnfuo1JZT5lwIIeMqrVX/to3u3hX7
 ILtsLwqhf3NH/z6FksQGBxRRQgia9w+6TdNWSpK6C/yUaykmvvJe1rQE7vrD12d2oDKF19AL5
 vpRVjIgOVolHENW6eg/wN1B2IybM5072+wj/6C/iwbChj/QipDy5sp3Fjrmc76JhNoEEf9XET
 NYc8Y5c5rBGfHyActnn7//gPc79MbsbTeMht95FlLjmrMHVsrcqObRAdB7LFKgu7iOX6KL5LR
 OP6l3Swy/+vkS0BjYey/TqbV4HH/P0yZiuOUvLmPq4ibpNg95BsJg2BW+MTDx2vfaNErlRqPo
 izZJVbV5lszq64FimqU2jHW/nfQMEmxtRbq99FELwEDgpxqb+zj5g0Kx4tzMRsYN38I2eb6gl
 eQtSA7qfT9cbIybFUo8FF97Q==

>                                         =E2=80=A6 The tile columns belon=
g to
=E2=80=A6
                                                             which =E2=80=
=A6?


=E2=80=A6
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -0,0 +1,181 @@
=E2=80=A6
> +void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
> +{
> +	struct amdxdna_dev *xdna;
> +
> +	xdna =3D hwctx->client->xdna;
=E2=80=A6
> +}
=E2=80=A6

Please omit such an unused local variable.

Regards,
Markus

