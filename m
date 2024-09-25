Return-Path: <linux-kernel+bounces-338239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEE4985536
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B43B2145D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CD15B11F;
	Wed, 25 Sep 2024 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kC9oMuRO"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F08158D81;
	Wed, 25 Sep 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251865; cv=none; b=PvfWC1oDVt6XAoYxALUo6nGQDevYP1ZIsKc4DryIAND1wSRMF3OEUSOUtiZdtmfhVnLHS+qyWriP5Z11/KY1UaZhUAyNG7QlZZ2g0JAH+qENgIr0fYNnys9vUhuv6iyzp1qgWmSkGQ0mTt35Mekz/JTpnPlCdSXDhCVCuo8Uy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251865; c=relaxed/simple;
	bh=HHl6WwQYUAJzme6Y7IXjUEQOFRMq2SoZg+WywkKQlFA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eLhP5xe9g03h3Id2ySe/WKqS4W8//5Zyw+yRo/0qWoSzIc9QwitO+ybu8WHTm4kZmMG2MR9gh9WzaJm3oTY+4VlIaYuohuFAYB1glz53NqB2V5JGVS6rPHT1NwKhlYD+XUDRXtd38AszVbhHpw9LLWmq0JMcomC8nwpObFab+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=kC9oMuRO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727251853; x=1727856653; i=markus.elfring@web.de;
	bh=FyrBvkfHDOPr+nJ141V43deKyMB0B1N9ZJUIyJ8uv54=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kC9oMuROGFHVTUphVd6xslEaU5jf04jxtxY/sxLlwZtOC1ESI75PW1M7zaNb/bIy
	 rRCgPw+aDOTBa6i5h3GxUgq7PSmpVQ3LOM2/KVBeL5jL1RTBWAp/ZbVOI5cHsV5k5
	 HLvsnUHbD3HNRbaUlSyY/oPV0njI7KJ0Q7BHPTrvIu6GK1folvqSBucIgRsHY7snk
	 6ueoGd7LT611qPpcpp4QZSEWgUnUVR7BFjnSrrEXzWC5Ogr8pESiSSPu4dGxtlKrX
	 9P+TZVv9htOgWH7FCdLxAa+J1LF0IzUp2ufM5FS0EhNu707AAZuHfDXJqQdHbgVlj
	 u592N1v2Ka5L+H2Q7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWor-1sEpV008IN-00hMeu; Wed, 25
 Sep 2024 10:10:53 +0200
Message-ID: <26b7f215-4f83-413c-9dab-737d790053c0@web.de>
Date: Wed, 25 Sep 2024 10:10:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] thunderbolt: Use common error handling code in
 update_property_block()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tm+byGEofqsYi7XmFVHVNPrI5zFcxZ1pLwSuSiEN0mLcD76JOBv
 1Ynakketst6oCHRgmz/tjBGJUYOl6LIlDavzH98OtFxVER4aG80sFy5jBkzLuY8OVleH1ol
 vay0a9O35SvpYkOcz4NjOB/NVpxsrBO97mfkhhVzRo29q0egbteBEztK63M+ghIayzgB+w8
 VqVcAS4KCrkDQkbI+mw7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NXP+3rDlkqA=;XYH5Kyk8OxO3UnZF/yMVHnSj5AM
 oyfd2nS8t2uzXDRo9rCd8xZBaZu6RoNtJhanopwN9E/0jKEYxEdBxFwcwFxAWgpa2A1YgDu/5
 ORdbvx+pyvjTV9PPw55iB8OVQw5LcNwx9O2dtWX7qHQzdHrO3coUP1RM3k2x/lR51ucRrCXWI
 rj34e6IRtYTrn01C53IrmqniuWp26AQ7T2NjVDsUC1OTkiOpnNXk1mFh9eOzXdwo3S37SjdIl
 yJUfFaDV3S1AG8LaYRxe0jN567vMDXAKN3Zo8t3sec61N7ohHRRKz8plG7T1pH3R0RniySUSw
 JqMvxVdEnP/A2LHI5z+csX8A/BYlG1uKNHpXOtRNtwiu+aSdo871Qrpx9tj+O3exXikisJEHM
 Wkg6xfqIiE4moIf05+3e5Y4uCiPLLAig03hGeOi5ELtUJehDTwl6+wJb//3V5y+Qarnyu3YEt
 R3herD6uJGtoWtzWDvd69RbOoFlZI5Py3iC094Yy1kS8ydjCnzhcCK7u9cskMbQFZt5bsN+R7
 TBiy0yOUyK5ynVNQzcOgTm7JwZobfnecZeMOaaChqyrvWicSY9HvLqsmXxAPopgS6mwlUa6yR
 koyD3u28MJRMoz6zkrdMab1xUJVUKUzM8BonOjabiLf4T5+zilijp+C1X1RHWv8cLCoAWcNed
 3oFGIc2fM78N9q+I70YzxODrAWydTMRctW/DOhKztI/lBCGPUfcOycAr/7rdFMPylAw8aD29S
 ne96Y387OGlImf9+OT9IGwdR6nU0QHPb3P2TFepw6JX91H9iB4o497OGe/GeelG62ahD5nSFO
 iJ9HTc1iVNkoIuM/0dnS6DgA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Sep 2024 09:39:16 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/thunderbolt/xdomain.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 11a50c86a1e4..8e3cf95ca99c 100644
=2D-- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -670,23 +670,19 @@ static void update_property_block(struct tb_xdomain =
*xd)
 		ret =3D tb_property_format_dir(dir, NULL, 0);
 		if (ret < 0) {
 			dev_warn(&xd->dev, "local property block creation failed\n");
-			tb_property_free_dir(dir);
-			goto out_unlock;
+			goto out_free_dir;
 		}

 		block_len =3D ret;
 		block =3D kcalloc(block_len, sizeof(*block), GFP_KERNEL);
-		if (!block) {
-			tb_property_free_dir(dir);
-			goto out_unlock;
-		}
+		if (!block)
+			goto out_free_dir;

 		ret =3D tb_property_format_dir(dir, block, block_len);
 		if (ret) {
 			dev_warn(&xd->dev, "property block generation failed\n");
-			tb_property_free_dir(dir);
 			kfree(block);
-			goto out_unlock;
+			goto out_free_dir;
 		}

 		tb_property_free_dir(dir);
@@ -701,6 +697,11 @@ static void update_property_block(struct tb_xdomain *=
xd)
 out_unlock:
 	mutex_unlock(&xd->lock);
 	mutex_unlock(&xdomain_lock);
+	return;
+
+out_free_dir:
+	tb_property_free_dir(dir);
+	goto out_unlock;
 }

 static void start_handshake(struct tb_xdomain *xd)
=2D-
2.46.1


