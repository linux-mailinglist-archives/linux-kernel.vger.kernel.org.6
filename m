Return-Path: <linux-kernel+bounces-348189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B491A98E3DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799DE2812FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9C216A29;
	Wed,  2 Oct 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vJh3uWvY"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C9212F0F;
	Wed,  2 Oct 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899380; cv=none; b=fPIME8SOZ/YppFCw7/iYjm2YvIWs/DwwDfXDruw0nE2glpSLfWuA2FUVnVQGrf387KRdGpSX1pv5oOJIXlYlOZt1D/vTLFQ3OYjn1i+2QKw9eX9MthsGUBcCpckO/CmSoDV7NyO9d2lSS7Jw7oZw00WYxttz55y8tbeGAHn+Rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899380; c=relaxed/simple;
	bh=nXmCThrNmuZQUi4BDS/SIg3d9HpKhnM0LoHaEUGa64M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=m5N3zGcFIShnzj+sVpwqRfd2QxAV14S2q4JSQIIs6i3aQOgsoqgAfNOcBYmO3YRcX3W2LLWVB1Esf/oDIvP9Kr+dbHpFQwqktAV/Sp5hq9l3oTqMekhLi9mKylzOTF/HByOSyoecU4yTb2/2iqiDDQJtJYPPw22eHhhpEE7AAFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vJh3uWvY; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727899342; x=1728504142; i=markus.elfring@web.de;
	bh=yk/JBSOBkQ1LKGKPJgjsG+d2d+2WBIGfUs3k8xorprg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vJh3uWvY+YI4HwG+Oop6AdrCMM/hC36uMebPO+Z/0+2j5obO0oaV+VEoEEypGxf4
	 K1fHJNZB1pF5m+rwMUANcpzvZawtGsRapzTV5BeDm1GHH0L20GjyMFb5IQJpD2S03
	 vonCVDWDDLjwHNicMTKwFzxihVTegFmexgJmAJViy+cjnrev6fcwSjmGqXaB+8PTE
	 nIJ/yWtaXmcFZm6GX9Xy5y2E+5u3LDtECmCtnwoQ/i7dM3tlb3SFND9dDnJXjY4hz
	 z0VSvqHX10a/tkGG2I38nDCNnedG0GjHCfIMigr9uWlolXcpU/93UgwlPUITgPZV9
	 2E/+iBVuRq+glIY7HA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1sKpr33AIV-00d27Y; Wed, 02
 Oct 2024 22:02:22 +0200
Message-ID: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
Date: Wed, 2 Oct 2024 22:02:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jani Nikula <jani.nikula@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] powermac: Call of_node_put(bk_node) only once in
 pmac_has_backlight_type()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hKihFzh+xQoapC4KB1f813ixscEmHDPGUzMwuYAGUbLDglss0wb
 aW1DRTpfjmTzAnntPjK4MUjjYybAkBJsvTKYbf4BiOL1MIfuY+vOQC4V8VuMjXrM8OeMu7K
 /YnNfHSJaBVEQSyddEI15nrtpuVaNLW+IpzMvcjtsNH1IUPdyxetpjcQGjAD2/ohTb28UrV
 S2d7mD6JlNhWOuly+q0nA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i5Qz6h6TJGI=;vi/+cqtGm3/O6HJzmQA8MyVuEcJ
 gnYaMhZqJzvwOLwF+Y8odsmfGi0zMGEJ+jIV430l1sse3ntrvjGfQ1YoXDGZ3ybIIjyG+Jwf0
 tapsJNQqHFFFJTXztb+oYwXm9ifnmxd2qp1BlS1ROvH1TxlIjgn2/V6gvBFgkXIGh7o/Wi1bN
 nTjvwAIxlDdzk2ll0V246EHCEtOyYJdzXBcUbHEhiCST+2gymhY6tDq9UAsXWspBHy0AjPixQ
 GNnIoStVgXi3jhbMEDPIZcWgbCytgVAI8qGC6gU9N5lRkdA9gwne4uHM9LV1yxPSM2888jfui
 13Nig+mIFTBu4IlJLFKM8JommUTVPguflFHjDZwJRIQZmegta25NJT8MsHFWTe1h+UK6AoLn2
 jKGwkEeKcQl0tlPUqJZnUxex2V9FvSGhe8DSgOMyYzCo7rfteczvgeYCyNOySr3wVcst9B9zf
 Ta29slZPO+tYiGGJpzd1tbY78cE8IX8i0zZrsM5wCtEmMZoRwtBeXhhPlE3NCFKXAGDClQ45s
 XJvCzRffCS6lxzwz8PnKZzyAfHy42uj+jY0mYm9ylFH2GVl5wTF2KWKk7RLrgNFxnbYHt75KU
 PFxXp2GZqYabtgKIRHjYRz3D2mOcyWH/71R7VZoEB0lmzejIbrX2iiln5TDar9HXA3rLPZtBF
 asQdpVbd0CB5xwzeKsooemCRBkk6dQ3y1bGGwmuG8gFsmozG5KTR4uvVHoFjxhnWupdV2X9ue
 0pqh760jpB4Ls1+VuoUT1jwcg02jQlP+K0ed9GtcywbuoST3JBILwUY9Ckrv+iOg3qmxV7lW0
 ux5vDQ19KuZHrPIPMMkOZsDA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 2 Oct 2024 21:50:27 +0200

An of_node_put(bk_node) call was immediately used after a pointer check
for an of_get_property() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/powermac/backlight.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/pl=
atforms/powermac/backlight.c
index 12bc01353bd3..d3666595a62e 100644
=2D-- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -61,11 +61,9 @@ int pmac_has_backlight_type(const char *type)
 	if (bk_node) {
 		const char *prop =3D of_get_property(bk_node,
 				"backlight-control", NULL);
-		if (prop && strncmp(prop, type, strlen(type)) =3D=3D 0) {
-			of_node_put(bk_node);
-			return 1;
-		}
 		of_node_put(bk_node);
+		if (prop && strncmp(prop, type, strlen(type)) =3D=3D 0)
+			return 1;
 	}

 	return 0;
=2D-
2.46.1


