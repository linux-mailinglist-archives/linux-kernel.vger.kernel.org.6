Return-Path: <linux-kernel+bounces-361478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3399A8C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D04D1F23F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1011991BB;
	Fri, 11 Oct 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XmJXUbV3"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C66198E6F;
	Fri, 11 Oct 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663557; cv=none; b=qosAA8DjzKXHUDVGwBIDv/guDLV8SruE+qx8p7bzPXqb80B4gL4pZ2xHUiV1utGpBc5g6boe/5GRED7a7U608sRK/ZUrnFPISOTG4ZnDLSKdMrOqdNbplyyl78gFOWEvHQdv+//bEMw9gjFVJ++vktYABuX7Uo1i5IcNqYQHyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663557; c=relaxed/simple;
	bh=jvLjGxR0MGgY46wJupTudWAUVwC7UmUL0afVDRPR0no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeYhHIeqdABT1wOs01N2j7KOgUckVy3VlF3AtE7CBtUCD8ul33ohvbuFw0kRlEKr7a1LL51WnQJnF12s2xks9/xV9zzYrTvBTHrnIm+YJCWvuKXXYOJSROvUUJQuAHf1u1EHvp4qYCLJMKD/eDlrWtEnXAhsD5IP3r2PV25zuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XmJXUbV3; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728663524; x=1729268324; i=markus.elfring@web.de;
	bh=DTkx67YeCxz63Ruh6fsf5H//CCWsfbXmJhTRx2qFiaI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XmJXUbV3VomOP2edKb/1Fqm4yHnBb0MUnBt9wwe1Jfvd8OXqh6VN+5JJA9N6klQi
	 i84vTwOCdwyxriRcZIgsB8X/tObPeQ+RwT1semsJhMMmxw9PjLTFe4ecZoKD6n/lU
	 5cpPHiCjDCMubMhu3XNHS3Y0WSRBfjyOxNTDKdQvIMtOuxU90PMKoAsHUmF6tH5s4
	 axlNBEZ+hn3dY1NqfYRm97pbLvPNjm9gv4hkPu9H6zQcdCtX9tjIJGPHai4Yf9Auw
	 hB/Rrem4hlCSSpm2tQ5YJm/fmu5BdlfQARDXxSwFhDLQrPtIpoOnxeh8joaRXQM1x
	 rn9a5Hn9l1y9yVM0IA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLifq-1tGpCW3Awa-00LYIw; Fri, 11
 Oct 2024 18:18:44 +0200
Message-ID: <ede25e03-7a14-4787-ae1b-4fc9290add5a@web.de>
Date: Fri, 11 Oct 2024 18:18:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] powermac: Use of_property_match_string() in
 pmac_has_backlight_type()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Jani Nikula <jani.nikula@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
 <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N8O2e4Yd8E0DvTB9GzAvLxn0nY0sITcEOqSjkIxd8kQmhPZmVqM
 dvk/RIK2R/oB3/C6vH0Za4HMmwzZt+MVAu2T/oW8Orss8Zk5+wW3pmJmLymePZ8QjxEBRgB
 /kUeUyNO1XiNX2igzwPABBHB5m50knkomXDgAOWWQqrRF28FQR+14I465PvgowRK10Jlf4J
 uGm6giXGKwnrulmV0VBkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:03Wv9VBsxxM=;Emklykv9AV86TehI7jARTBVzWrT
 gmVAPBuaUkIGkzIetN/j9chswkNCMekAnfGMW7UDksYMQDxzknkyAbYVY2glTnAWaJ6SUCdEv
 +ISapxLUpmQ+jSsy7/JOPSGeRaOW9oJ9gT6JozPbkwt3mzjwFGg1kg93q9qKNeZiDb20FQ7Z5
 7dbMyhRO7IoQUCPFRU2pZONu3UZ+PwYNSNA7N1tGZM7p8qMiOwqRfmUBo2iS8EcFOTrocBiqL
 vR9KrBxbxhFHxFQOntbrB+ofNBY1oMG+mzD2Oi/2mRZTiLus5YtdHlT6VgALTCKzquhq/mBG6
 XdjFGakaU/Stza/9COfiiH5iyPUI6uAAJCttGIVpSUG5z9tkinXh4XvAXjk4urs7M73Vw7KIK
 xE21MPozV9FlUQb3Opkk98YS70fV3YUULDZOU6Qvu2zmUaPY9ixhX5NyzY5SP9odV0PnWxHyr
 BYq2hkAoaS2HU/MBRTsNWelKG3FI9aPBERKHXvuG3E2k5JmOemMYE+BzRONFM5CaCvik5fwGX
 9sUOEfXXxhh+7RHjfwsJhE0WF+ItPzhXW9OIob5f9tF100PLWUf38y79dHx4IGMkObCdJN5JF
 qfeQ2Ppv8pROtfNg+pv5LEZqmP2DUAz6t1RjssIlq+81k5qhbtsHVza0m9CDqpsQ6F1M4G0oR
 oftcGu5QqkU7IxiFPxZICiHYS6HSlj2Nsbr+NVGBMDgtSY+OVStYecDG6lfmICKYpIbFTZpnQ
 Hz20Ms1RAi6CWFzy13lupfmOZCYYVsrtzxEMVIIkHlh3l9gZc4JNmP+uRiY5alGgAOXJwh3st
 W8Jk6EgV8+Np5xz1nktIgPwg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Oct 2024 18:10:06 +0200

Replace an of_get_property() call by of_property_match_string()
so that this function implementation can be simplified.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/linuxppc-dev/d9bdc1b6-ea7e-47aa-80aa-02ae649=
abf72@csgroup.eu/
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/linuxppc-dev/87cyk97ufp.fsf@mail.lhotse/
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/powermac/backlight.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/pl=
atforms/powermac/backlight.c
index 12bc01353bd3..79741370c40c 100644
=2D-- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -57,18 +57,10 @@ struct backlight_device *pmac_backlight;
 int pmac_has_backlight_type(const char *type)
 {
 	struct device_node* bk_node =3D of_find_node_by_name(NULL, "backlight");
+	int i =3D of_property_match_string(bk_node, "backlight-control", type);

-	if (bk_node) {
-		const char *prop =3D of_get_property(bk_node,
-				"backlight-control", NULL);
-		if (prop && strncmp(prop, type, strlen(type)) =3D=3D 0) {
-			of_node_put(bk_node);
-			return 1;
-		}
-		of_node_put(bk_node);
-	}
-
-	return 0;
+	of_node_put(bk_node);
+	return i >=3D 0;
 }

 static void pmac_backlight_key_worker(struct work_struct *work)
=2D-
2.46.1


