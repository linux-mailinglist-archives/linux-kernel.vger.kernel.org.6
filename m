Return-Path: <linux-kernel+bounces-354779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F3994280
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431A11F263E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C751C3F08;
	Tue,  8 Oct 2024 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="evWyjHu3"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BC1C3055
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375438; cv=none; b=ixgAkSGTT+MGz3Gi/MRrID3U3APu8jjJKe4pCWbnpQQRdQ+QecMYphNYeF4kytAje1wbb6rGX3CnTS98qDJhWHT0K1DN994Y2EULbBn2lHuyQwvHF+0RFFNKH7iKib3ZqAvhfsuT+5fhPzLPoPe5Bn1iE23gdjCdL9bDqDeYqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375438; c=relaxed/simple;
	bh=k5rh6i/b32YmatQlg08n2acCZgxFxfxSHLwtuhVYqIs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nPNJ2x88WH11Cnto+nPVBlnqpjASNKvFZ/RjzvOtvj+/tbMP985cRPvc9NOA2/k3bIMfu3myNqizfCrxLzPXJ4zzytWVmKxT5ityFB8zizBTjKlJzayi15I6AxJTQUzxjlfG7KTME70zikwnAqD7DRCPCH3sMNxvJUpB+lYuzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=evWyjHu3; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728375404; x=1728980204; i=markus.elfring@web.de;
	bh=Ul2VVXH4yAFhla5kOpMVwA5HpYndlSc1uJyqi0FG6jw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=evWyjHu3sRHqqrrfhTyWoCdKQKxT2u6NaFaSfDoAD3B4lA6ff6y8pvadPGREaj4K
	 SmQxcZYhx3t9UbbjgTgr8X2OE2xVwjZel6Vqz/WmFVYz32JHUYx+ZZwIFm4VILGjK
	 T8VyTj/28r+YHqYgDb3JW9mSZo+lRbQYmaLdCCr6BD6tp+/6JdMKc4HezKCAoMPk+
	 hmXRjdaRdMTeWY/t1ZOS1/9V+OERfSEo5F6l4yMuIcfSDIZmuTzaxf1W1SA0s8b/5
	 UNB4pCA03FRUMij4A3csWrk6HItK5RsFAZzuLAcwKrJ7eb4asudRg9cMzv4zkXjgB
	 mJHM7k2OgTPD+TH6QA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQud-1tVoSl3M0x-00TDhn; Tue, 08
 Oct 2024 10:16:44 +0200
Message-ID: <0116377a-cbf1-45d7-b961-4ef0198ad8d7@web.de>
Date: Tue, 8 Oct 2024 10:16:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Adam Thiede <me@adamthiede.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Nancy Lin <nancy.lin@mediatek.com>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>
References: <20241008064716.14670-5-jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v10 4/5] drm/mediatek: ovl: Add blend_modes to driver data
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241008064716.14670-5-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/45JQZTFUrLmsnNO2lMHMmIKfcQ7FjKtxaiHnVyKHAn/AuAQ6wy
 2jmpg/rs12xHsFV1VZTGY5bIwvUuOqWMVXijl3MuThJxYYU/lp0prh2ip3mp2YA0bZiMIuq
 6Cp6RuDPHD0eWnrOSsfe0DveSBOqvi6IvCV+PRuJMNOLHM+/lEB0rNIufc3hRrn+Jhl+mx0
 GrrjNKiRGBDLdktY5afdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZrxzjTqyd20=;hzAgJwDX9T/8GAXHZfhFc6x5vtE
 /J1DXUfcnGS87XYr+JAirPZ/yNXoozNLi/+Kf676sAhuYaQkO7HAUCPx9DLfQyMaCV9EO4AbV
 s2hu8PMYWj7/3iVd1hKRj6fyAFMiWb/PGKCoHG2bpXLMW0MLCUGeiUH+PDcwZOk8DZdubYNFc
 lUBON6DppWgPp5wQpjaCvy28SepRR0OKKVM+Hg2rONTf6c8N+kBaVi4+ZW+hq7XnMo1z8kcXd
 841cA5OGPfKAoA00fNdLSR0rf76cUPGMgoNr91lQVIdokx1piMIW34NlJ8eTT05Uouf/p2uwi
 zqY948fVpXEOyC0c4w5g4AXVtzbzaFbesGwOwe5uYbBWl6cdoCPryKvWZEC4Ede1BM9Kzie08
 0h1aubk+Q4myc4m8V0hRZD8Xe1xGp2i2hwOLIZTIzHG5MBK0Ku2AnxfHz9tii5F5Uaxa1QhK8
 U7IZFWGY/VLZaWIdwTKZrsrRqcC2caINtAYh8uXgxTbRL4H9EhVUPtpKUc8uTqL6sQK8wVWJ3
 UrZYs5R+J27v4wDlslYFXnQynSMpyZcXiKyFUULmf/AEta8nKhxUbgDO7m7p3MU5sPFuF7PVB
 XsYfaC8NbGnhHpXqDTpKX2fzGx+aBsIt6U5AKyEIEE3RlWP2SjT6DJY7G5cA+j3oXj2gkxS4C
 +hOMXvNJNWNpjG4P6dz6Gv/iryD7aWjeP8Pm2046WhSyuA/F7ITSs0rIvjZlko+d8YaqFLzi6
 lsI7Qc/nTgcoughuuEr6LQkic5MYGv0ez6SgW3MZnQCLIjubsu15v8vn5F9C654C/PvY0snL/
 hTNJMNNMliFC7paciNy58x9A==

=E2=80=A6
> pre-multiplied is supported in the current platform.
=E2=80=A6

                format would be?


Regards,
Markus

