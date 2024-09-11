Return-Path: <linux-kernel+bounces-324961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E247397532F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63952848F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3595118C912;
	Wed, 11 Sep 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R8Fm2Vnb"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C02F860;
	Wed, 11 Sep 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059939; cv=none; b=j/x8WEaFkgkb1YCj++yBFWJyRaMNv7I476MIZe5kWTjc8PbXYt5Yc/8oNu4RAm3bFKpcqPgpjE0KfPYWvcEzT3ofUBySB1VoiNu5WxdeBDyzwa9yIuDuMj7c78nd1JkLcuI+CWcNbmtIO8RwZIdiC//qrEGF3Ja7duFKVIBNuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059939; c=relaxed/simple;
	bh=bDYUgYOw46wNC7ut0zToIHWGq3V5JzUlJWPhGwJuAuc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=r3LxM767uTUpggKkPtH9e466N1nbfLKZ3PnLKld4IIKHup5z43dY3RZNBykZ4D4P0krZH2PlXHeD/GIeML1RdXK4hBFXxpjNVxXg3IXWWYw3bi5OiHI/hII3ZqlI5TzS449UH5PKpv3BMuG+x+uFaBmcWZvr04s2+l/wErRoPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R8Fm2Vnb; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726059924; x=1726664724; i=markus.elfring@web.de;
	bh=VRkf3qtyEuvNPD1JX1MQIlWJSiOtwVTdx3GCCgh4S5s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R8Fm2VnbqfNd78zQHzBufZariiC1mKsWsK9p5SU8IarkvPvo95/3QgwS9yvaKs4T
	 +CrqLJNnbRwe6ys5oeEIS2Ynp8KHnlE6IBS3rDbtog7Oq1kfq/Lo5VqD4PGfPrN0K
	 dlvDH9uIjMSHB7Xe78L0QPMTb9e2YHBVr1axk8R9m3r/WpxoSErPyxVaPfO3WyOPb
	 9MAoai2hdH7EYWarT/roiUgGpNttquO6A8jZIs0iVEr249QzCVogh8sPHmk9NGRE3
	 65/CBS+PNrSysUh0QQseH7Lar8RX6EDL5Rn3rJsoez3XsH9MhAOZVwyS0ld+z3vhE
	 8LE8sWXXEw7MvTgsvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1sJPvg2Noe-00lz87; Wed, 11
 Sep 2024 15:05:24 +0200
Message-ID: <aca066e5-8f8c-4c08-8c8c-8743e98ff7f7@web.de>
Date: Wed, 11 Sep 2024 15:05:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ruihai Zhou <zhou.ruihai@qq.com>, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <tencent_C3AF1A5AA6C84EC8AFBC9434383912612209@qq.com>
Subject: Re: [PATCH] nvmem: core: Fix memleak in nvmem_add_cells_from_dt error
 path
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_C3AF1A5AA6C84EC8AFBC9434383912612209@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SJ3aD2gaL90RIFjIU0KY1WCukPSJqpp0AO1aOZN1wvN/uaQDRIa
 KWWCliQKc/KJiRygSN2B9fUqShbBHfh5hLv/ubzk6rvopxNH48YlzkmI6KcguXt1p+pI8Xj
 84oS33UYSGj35wBRa/MhziN8mBE+7/WOzqgT2+Mxw93mUv13glEoOhgutpNkkyz9MOyPbZi
 uWMw+0vBTzlp9YAWlh/BQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JLStHIiRUyc=;oXwhKkvxpqSxrd7EPWOJNj3EHN3
 pidhAMjBnAWxB346QEIyy2MSF31mRLapRNCEZyBL5c6Et9XZtc8F+uAT+Ykg/0LBRxmA/1/Tz
 veHiHoXHGqnWAWDDmIci6tkzPsCbwz5Dr8btZqqdiJ3gjKCkMnNnjFdr1vfr7s4IR9veU1L0n
 2KookwqSyYjTboGZBJ0sm7vDh1+NR2TxYBOydFqCFRFLukYa2t8xFvgSiir9Bore5oM1ZzMlb
 xOlTBuhivQ8wD4Zlkh8DIJ0cljToWEbBrQb454TnWbsAazL82TND0O8z6+INMg+NKV0E0nS6M
 ve32TkJoH+FDQNaMfH+m87ZwgOQdGvWrLfFVSLslsZLBOdpqDaikGwk0+zz995Kkifvx6I4qZ
 mP0GJhSxhtUxpHzKgpM3y/Oiv4s8uWNkHCpWMpf3fW+Q615t7SN7v4iZ4qmXjwL8P/NQytJ2H
 aK9RtcSXe3n7jwouJKquZcd8rFkwgwGhHbvFf6rnBQ5vD09zhgQOFVGhCJxHqlbDxzNKfQFKQ
 CveMyPOUD8VIkOIKORgyes/q50e7EQz+3arFhXck2zrVS8DuAqPEWn9RLgcagOBz0uu0haUir
 ye3j3Kn2Y5vTDrcVuCwjZiJIj8sJgq1Tx62cbLywS41OuplbnU63DG5FHAf4bb7NN7uYM0dYF
 kSPPQJDo+Kwqp9h5O+wUFQk3hu5c91pF1aR3/nof5RihvaQeBvIhvZeL+E0tIew9tkoC+Pygy
 usDRSbSGDwLxtpxgOS2qNUuE4uhPjF/OcEMyL9hoD5ao/k9szyOwu1ESON3KtPqukKWSoggLL
 SRl/lYgkg25pvW8C0GK+5+jw==

=E2=80=A6
> is outside of the valid range, the info.name alloc by kasprintf will

                                               allocated by kasprintf()?


> cause memleak. Just free before return from nvmem_add_cells_from_dt
=E2=80=A6

        a memory leak?                                               ()?


How do you think about to increase the application of scope-based resource=
 management?

Regards,
Markus

