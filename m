Return-Path: <linux-kernel+bounces-336257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD11D97F12F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210BB1F21ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585FB1A01C5;
	Mon, 23 Sep 2024 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lzQRuxGV"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E1915E86;
	Mon, 23 Sep 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727119762; cv=none; b=fy4oYj0nZT7XNExq60KeZzMPKijH3VZp0op5/In3WDYy8Vp48sBKk02VHC4ExKIRvq/sgWLxEAkRhA3/rC/DhIzNLoAju+YPnNTdeil2PzXekGSyAxZLAHpDnrxcQ4pQbcyaNYEBQIhtuFq7U3VyKmKJ8ruKUBgz8Rh5zAJ6FPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727119762; c=relaxed/simple;
	bh=e9lDkdpWy+qCLfVwcrxsfV8XgIXBr9xMhlhGoG12zwI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JfRVX/XB53OwjR3T0jlEWEVWcb5LOhRx5u9PLlAOUZRLkuyzX7twDWJM//DEQC/khd/fHor41c8IVeFL8gH8jlXdbvm5P74JuOSA9ov/+fQBaqvsILpBbhA7UxBfpHN/WuNkfAO8fPjkQ8fuQQO5goIHAp7atXqNDEMKs1H82N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lzQRuxGV; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727119708; x=1727724508; i=markus.elfring@web.de;
	bh=djbkrGXRtHq7orMC8Q8l8m1TWgw6GsJVQydsMLaFwc8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lzQRuxGVprEOZcwfDsVMIynvys+4FfyL3XTOSrVRMsOwJtmcSqEK76QVwrttUD6A
	 n6lrbaR3amC3BWVN7oerHBdMohrRuPMMMOd1mgXoYGjeaUmXd1Ae9fx/hKAlfpTRb
	 XOm/8UMZBKUHKj1rCbpkmLLTWbS0hekWDPp3TLRG7qII5vEobMN0iO/NizqsAxuvk
	 gf1qb55bLwUn3Uhb2U6LegMv3//Ymaxqw8OvvjfPklosbcumjBlsYdc4Do6f4Bn2I
	 7J/+GN3D3NnnfQBddLZljEr7jjcmYI1gXACn0ADa5uO4UGXvxVyu4b6LIhVCeeWNp
	 fA6GKSVY3Y8gt7nJ/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Mr-1rzutD2pPH-00ytzp; Mon, 23
 Sep 2024 21:28:28 +0200
Message-ID: <2f84f558-3f65-4c09-89b8-485830b98654@web.de>
Date: Mon, 23 Sep 2024 21:28:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 John Garry <john.garry@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Mark Rutland <mark.rutland@arm.com>, Qi Liu <liuqi115@huawei.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>, Will Deacon <will@kernel.org>,
 Yicong Yang <yangyicong@hisilicon.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] perf: hisi_pcie: Call pci_dev_put(pdev) only once in
 hisi_pcie_pmu_valid_requester_id()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8duds6sd5ZmSPqOeRJ4uuEaJhMIYGVj1GgAfwEil8eQ74MyJXfh
 MC6aBHbnX/dGzeLx9nblCjnSYQgWJSgBXhzGPl/WUXcEujJFDi5sVG6eW5C1yyNMhK8Z/ak
 aIMqM7Ae2nyw2tHM9nTQROA3hydHPbvcaDXHBwgoIRJiT8s81rKeEDV5GXPzXyc+ESQp4rP
 74AKEvbpWTiirItL+FLhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:irXljewrlso=;jJb4CF2hUg2EL37RJH0k8OceEBq
 dPDz0WsyioqT8Y9KZgl0GxFuhw3FSaYbkLM8oLzbo0g6EwcfaELASDTpdFkruMdkt3VTnwc8E
 2wIJneo4C54t4wl0k+//R7HcC2dtfHWEuPasUNxKp/wFhgTf524eGG6Sw1oggTmk8/WWI3Wz+
 AeqIFb6BXy3sz4TWnP4OCR155A5mxnFz7u3hjGoM/lbQBu07nUTcoSj7eHORa4i9yO2J4CDIl
 JQZnR7y/masgPFbZQ4Tp0vGnEAEFCmhRqLNg8OnutHPvLQYvMlK0VNIWrgXT1BZpkuov/i9B5
 D1tbSc96dAM0NLPC6UazhltrNC0YIe9dG5TLpxGlZireG2Rd6qI7lL3Yqp+7uNozlPjHf0vsg
 TN5ryWI0qa1ZjpCS1ODAcdXZ9LLICOXsIwlm9678YnuIubtjdZ13h0VQvwznzQFFmluzHnxiM
 LnaQ2vy3AT+NpiTP/uT62xX87oW5oMjaHW1HYOS5xAmJGg//XJ5kAKbykbgYFvGFKEydEaKi9
 8dxiOzjFceQU33eBj3OUFmWie4RG1ArR3sVuhQOZhYgHgN+eXU340yril4WOmkyVrTz+CkSyk
 C2qWn8eVjLZFsRStAbCFZ9ngOJZym7mVT/o6asaOHnjt0qoyc0wUiAbo6GlOBsH5euEO8xz3V
 ysMp96rdpdWoYaVso1w7n49B4l7F/c/Or2O9kliDgPpZeUm8Hz0e0lvO/J2u4FDpyrD0jAppR
 JCVA7tRgNUV8w0IbC2pvs4fKR7nLX+AY64YuhVyl9mlBgY3wWah3u1+UVuLDXaycfcv5nb9eW
 TWs3m7v3CskgHq1AlWsjZ0/g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 23 Sep 2024 21:17:45 +0200

A pci_dev_put(pdev) call was immediately used after a pointer check
for a pcie_find_root_port() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilic=
on/hisi_pcie_pmu.c
index c5394d007b61..5ff1c47d68ad 100644
=2D-- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -290,12 +290,10 @@ static bool hisi_pcie_pmu_valid_requester_id(struct =
hisi_pcie_pmu *pcie_pmu, u32
 		return false;

 	root_port =3D pcie_find_root_port(pdev);
-	if (!root_port) {
-		pci_dev_put(pdev);
+	pci_dev_put(pdev);
+	if (!root_port)
 		return false;
-	}

-	pci_dev_put(pdev);
 	rp_bdf =3D pci_dev_id(root_port);
 	return rp_bdf >=3D pcie_pmu->bdf_min && rp_bdf <=3D pcie_pmu->bdf_max;
 }
=2D-
2.46.1


