Return-Path: <linux-kernel+bounces-538541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5396A499FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BC07AB54D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5526D5A2;
	Fri, 28 Feb 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rR6Wzjg+"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9E26BD95;
	Fri, 28 Feb 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747079; cv=none; b=ooXWv41yIJpLlrXWic2Um4CSx75NdqDezGrlDuwcafhYZUtO9RRofb0NlzAOKyxhs/sTYpFTRw/qdtSFJ8wM7VfRLfy9Hs2F8lj+2yS2k02pvg6ut9meDi3nLfWb54Ct5Sr/O2FB3wbdr/qJXoWkxnUT+QROjHvlTpblMh3BiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747079; c=relaxed/simple;
	bh=scKazGwuzOTF12erXSPHX0Xf0go5XekomeaFO8oe4v8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SqjtG472416K07f0kLj6ZfbGBPhUPqej0wQ5l5YyRZoywYy/nzsNeRDLLzHKzAuHI5G65CYw/qglirh93NCWDWdRW4t5vy/ks1FlMtNaMd16O9x11uhNPSCs2x6bqknYu4gF7GIUgvPNl46OG79A+TAkevGCU+QmCYCqYp6LWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rR6Wzjg+; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740747069; x=1741351869; i=markus.elfring@web.de;
	bh=XS/kHt0Jzd2/r+Dt81keCnHWhP5OI706u2ZqfH4XrUs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rR6Wzjg+uwiuEn4SZcVLqURjXbBpduacdCpjV1u7NyTpopiAhge3A2tHl1Y5HWUL
	 BaDW1qy6b6603f4dqe9PGt0HmcKmV9Ei+Nfl57/D8mwhEoes/HnP1JPDD0g4GpDav
	 wRJ0RQVRalvDPUbNF9Oh6kUS9QHNOQet6hTHs3IFhYAN6v0GdD49FJQopvJM8xPyN
	 TfKJUOPc2UjB7YDleLlQ1MuB+27uQKFb+kFR+UiyEXjgqm6kKLOvE04AC6Jj7oxfu
	 /17tN5NlAjsdt1pipZ1/QMk5RTFiphz0ZRMkNmQxk38jtjw3K/xF/RekSy8BLF70j
	 oFENGhmE+3C1cVf8Eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.27]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pUK-1twFLg1UZq-007I1m; Fri, 28
 Feb 2025 13:45:22 +0100
Message-ID: <6b6d7ad3-7d25-4cf2-ab96-ddeed341599a@web.de>
Date: Fri, 28 Feb 2025 13:45:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Qasim Ijaz <qasdev00@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] nvme-fc: Simplify minimum determination in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1JnjCFQUd0ttsIBWN281lO5nPMzTF+jyUeD2O/xAf3vIJ+adx7k
 cOdE3IDMpOUADsU0Ezq+bCzt4CYYDqWZI4Df2LgkrJaVT2o5yMdxVC6PgGRZIVvquEZC5XL
 fiJF/X0XuHknjvc4NlikDHSXTtwbIHSOI3D6fIPleypTR4u6fdtuhGdcFnu6FQrfO+9M7K6
 DqofhYYC7m9T1sYkKvN9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QaPtVwaH4T8=;RAAFo7mD74pRr9Y3NLRGKhosheS
 jqtO1Yt2qLdIkpJS2ynbwYWgCB6fsmgoQEC05SpxaaDNwCcGqnaO/Exa6E4zRLyUL9nhetfVx
 qD/VBgABNBXB8VsioXMPmQ9uiTSmFYh9BCi2RLYGLHMHlzdIsmo2nsGBI25CE2j0QXhyGTHrs
 fbH7QIw88baD4FXv8AIsBTxlIZst41KmQZn1bWR+D3jg8VEiwwG44Ezz3ikwW9NTWDDKULurI
 wRU7i1YJVoFTuIkYN1ImMF7hDC8TqI1NtqBW+631uNhhmYGQ3/YI4pYcpqsHAQdkhDnIF86gv
 qQFjzc1toDFOXiBEH3OyM9KyhSxQPmmujPL8SlbXSsXHBbyOZOIMjJJ1yl77InUOKynNpuf7b
 2gULk+lW1mfiZeHc2fDvXylypqcdK47NfWy24odPEgT+/SDCoS9tEAVKTYoLlB/uOIGCMJHI8
 lkzMAUJ68QqU9p57paZHjFAPj83+lWhAqF/B7IaGyHB8iGvCwPytH53pAIVsXOVcXJaE5/bML
 M+5jK+yRbmtASDyUsd7BMVK/I2/BRzVlbHVDADopM9wHXVX3oAg1tRFQfPJH/P8m6GvL/uVs3
 7AEu3YqDIaqL0+nbgWIi54OpjmrkfKRPhQrjr+O1clcUxMrgJX5ly7qYFSiLEG/XaAZgnCcwE
 1nR8egbXnywDdPX2YrRTHGH426mlgVixJh+ZdiJizh9oSG7McwVZ2gBnPasYELCJPWmPA8UgO
 0faVDlbGMSNkOgkOsILs+Y576MHJ8Uxmds+MnFQ1KQxNZkJILDpOEe+BEnFXbphSI6naKLlY7
 hSbqpO6XfOqUgdYakE0do36I4/I4hh/Go0YEbmQGE9mc8T+UxEABDFTzPtAJVDzEqri3M757o
 czzYmVPsUKEPfRZ5pU4ctxY2ffRTogOmdcfHpwM/mK+zWJG9Gr8GfL6rGb615Z/we/xX4W0Ia
 vYKAS91aSWgZ8tFRyIbUEo8gMDVWXSHqXHfTNSxI2smu8GenizGbP3wF2Qcs2NBe806Y0zsZl
 yd+7t9sfX/NEh2M2npJyUJisbv4Upz5/Ld8WUeTi1EpUNNfCOmlxAsZERaupHGKHD+dA9TYwz
 G5m0sVT8h6gMC8tV1l2yFV1FaJDM1YUTaGWrD54nXikR/ysE98IBLKmVKlwDXUkX+mSd+D4Ix
 3ce9RYW+zpmHB912XhnPRmW8C+WdnpdjnmN8OCmk3avXpnPwMtxpcCTRMV5eozS7lxt0trHBQ
 Sc7Yvpt5m/ojX1T+SfkhCr2e9YIXINwc/7bd8oDHqGA9ChqZKaU8rOSCkzJC7lsqfMtanhD/E
 VonjWow7UWiBQaocpdHKur8aqdt7/uqdgCNe3xIrlrNbWlMpuNlcI32yzIHJXF9iDGUSlt3gz
 eT9C2JYOXPojYf96ToDx64wk4YduiDvgtYrAxXzBco2MARcsNj0OBAbZ4HWmBapxUcmiLKfDE
 W4gE8StanRrfvWdpN1PCHG7acFgc=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 28 Feb 2025 13:38:38 +0100

Replace nested min() calls by single min3() call in two
function implementations.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nvme/host/fc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b9929a5a7f4e..6eed3ecdbaf6 100644
=2D-- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2858,8 +2858,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;

-	nr_io_queues =3D min(min(opts->nr_io_queues, num_online_cpus()),
-				ctrl->lport->ops->max_hw_queues);
+	nr_io_queues =3D min3(opts->nr_io_queues, num_online_cpus(), ctrl->lport=
->ops->max_hw_queues);
 	ret =3D nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
@@ -2912,8 +2911,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl=
)
 	unsigned int nr_io_queues;
 	int ret;

-	nr_io_queues =3D min(min(opts->nr_io_queues, num_online_cpus()),
-				ctrl->lport->ops->max_hw_queues);
+	nr_io_queues =3D min3(opts->nr_io_queues, num_online_cpus(), ctrl->lport=
->ops->max_hw_queues);
 	ret =3D nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
=2D-
2.48.1


