Return-Path: <linux-kernel+bounces-332876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E397C01F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED422832F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F631C9ECA;
	Wed, 18 Sep 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nqOveIaX"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B33D76;
	Wed, 18 Sep 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726684368; cv=none; b=fPRY+AdHL/ULjGi5F/jTDZUVpnTJSA5C9eVO8gNOhskvVcFp+DbG7+HOXJKvkKfgvJpQ+HuNaqYSsOwg70bSfnPyB7xeYJZ9D2ugjn6g7WQJurnlyytHnxSGYCdMNYXF8xxi8DE6xWWpct02PwxkjADxjbhwN+6NbPmjYkpudKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726684368; c=relaxed/simple;
	bh=YJkeuTsxBPiyvTUP/blR4RkykjAI4i8ZteKtKxrLGL4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GwJffbmur15BzEV5+uYUiLDTjje70JTGOGJWos1oz1gvCPOrAPgkmdS/qSGaWTiwI3NZnj2HXr9HaBKR4epbEkt5azDDwy+RmZRCxLJNj4nein4qTfRaxvrrGYrRQrZNGXXXw7YQ2Y3uArXoTJt8OxtqrT/aE6l47ZsTSrezL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nqOveIaX; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726684348; x=1727289148; i=markus.elfring@web.de;
	bh=O9DaIs4hHxakPCjTXFbcAKjoZvONlDT+AZcVxmGqFGM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nqOveIaXitWWy/I6XyvWDpfx/cQ5x0BeLn/Jh5wbt4ChBKTTjPl4JxrQJ7m4lpwN
	 8pYFSyAZuN6RsZ3uFjUt6SxkVbZ9CF8CA9jYf8SuKvQMX2bMZjuzEc4vazzraGaBp
	 LLAvxJ+7VkVcsldA3gHOo4XPsZPt8nGOYuC1+0mztIL+JZIUkeVkNveO2B9GL/Yt0
	 fbaqTmzA+5EPKT5Ft+fuCQXJfg9Mh/QGLu/ZJ5l+syfn7WhQNu9FUnGuUMKNNvDfL
	 GSpEWHn2wtdZoGjRTNAONxcZ7GOGvTUxJulMSE4E1bVrhY13ldcf0tTBpAheUWthF
	 s61m0K0bGTLmQ3E9WQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwNW-1sITfh34y6-00q8iX; Wed, 18
 Sep 2024 20:32:28 +0200
Message-ID: <089721e7-367a-477d-a4b7-a712244bb5d3@web.de>
Date: Wed, 18 Sep 2024 20:32:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Layton <jlayton@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ibmasmfs: Use common error handling code in
 command_file_read()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RtVSD5Q086KPJxetmZJImkzST/1+WdkD9aPjnQeRvmEt7sP7UqN
 QEd6kYM+QNo2iaJUHUzJyDoRVb7ke+yfpUX1EsCPYmTjJ6xbiNXdxtndXYj3eg5uD4NYdOs
 ow2pwxC3KUnE6E9ZGM0x2GkSh5n+9xm1V+s7vK1NN9HFwatvHt0qyPsiNAsFA16WN8wGQhm
 W3Ruf6xW8cto0XKGfKOaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XDSV6qVQiyg=;zWScRs4z2W87b0lQ95IZPo4Mibx
 +IyLnF8FXlSb0MwXFis1b8US7mWpUEeHvjS4XvLYnmGVkmUoetA90GJpBgPYDcN3C4fov0b89
 wqGH69RCuzcuME9SlVUGlEGgGTbva/ugQ93yHB5YxKiXmaiI7uTtAGMDiXZgsvGNFN53n+dNu
 I2aDWwMf6lLlrp5Jy65U7ICf1Yw6SKs4+Oa0m7Y3mqrs4gTePPDdr2bqHBYSecSc+QjQgsNDe
 OTKofHqoe5wF/U2HH4bDCwz7e7drWUtKoMU7dpaZRt37XiU8M/wOKZG+j4uATMdCg7ORx3/x6
 +7vccvUG4eKWTiEeJWWMLTWnqm7rNcLld/xXldclWw0SzEzPIGYfblSynIGNOUCQj+RLYIz0f
 MU6CMjDI6l3YQJhF7RYefXrqdIJY8WyYGiOIeJpcWuph/PjgxAEduzXPAwV9h3wPWDRs/MjIk
 eJ7clV29Ubw9MZtBA2mJzBpJ7MlcupFy5AbneQF+kIsZgVRWm3Dk7CobvZ9/qJ++UylIDRgAf
 RYReWV1izkZI4EcHRRTU+oHazxKHCBNm2JtDl4a8oCPdBJKxgbWagVp5VcHbssGTV99//8IGL
 kSDpr4GoJiEgQjjHu1HIcukYy0JNm5ly1VUWYYWQufdlczEYSRuYWE1fiwbojlVN0+Ml5jB1U
 vzza4MwrRJtRZyavSUll7q1IkN/a/CWFHlel8zpmqKxluhf7nEMq3PMh+gmAsHE9DRl+ZPFi2
 4juWhjrTMcSr7SCERohjQ+OExbyFQUz0tQ1WzTcSO7AdZVliaKNtKSNvqN77yQ35Htlr3AXZS
 mw2He5C5iCWs2Gmi9KU9nr8g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2024 19:50:27 +0200

Add a label so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/misc/ibmasm/ibmasmfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs=
.c
index c44de892a61e..93b69f473452 100644
=2D-- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -280,14 +280,15 @@ static ssize_t command_file_read(struct file *file, =
char __user *buf, size_t cou
 	spin_unlock_irqrestore(&command_data->sp->lock, flags);

 	if (cmd->status !=3D IBMASM_CMD_COMPLETE) {
-		command_put(cmd);
-		return -EIO;
+		len =3D -EIO;
+		goto put_command;
 	}
 	len =3D min(count, cmd->buffer_size);
 	if (copy_to_user(buf, cmd->buffer, len)) {
-		command_put(cmd);
-		return -EFAULT;
+		len =3D -EFAULT;
+		goto put_command;
 	}
+put_command:
 	command_put(cmd);

 	return len;
=2D-
2.46.0


