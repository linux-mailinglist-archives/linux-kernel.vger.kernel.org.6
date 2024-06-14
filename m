Return-Path: <linux-kernel+bounces-214838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647E908AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB47C288289
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE46195968;
	Fri, 14 Jun 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Kq+Lteve"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689614D29B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364961; cv=none; b=KvZXVt8B3IEt/Udh9MxCiFoFPaE4+esmGp9R0jr1AFWE6Ie0k8auxjQjxfIbLJQHJim5TV+5Y8jbF9clKsSbicQxXaynMWgz/oq7WRjH6wNHYlyL30mKSCfAc7OMuebII5ppy0wsjnpE2YGE8Oxe5E++++lKY3gP5cBRjMaHV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364961; c=relaxed/simple;
	bh=QmppzqLNvLCWZT8Fmx2h1z/cJHb1DSDU6hZwdgDNQy4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=At63IuyenY4McC64ok0lXaVJ4kgSDrxuiJOzc0MmPfXrjHHsRCI7lfle7Ac68q/z/jeCXv04FVcsZRRY62RfGIiaJkXti84pzzxNqPbItwTwzRFRqYQW+pcX88wk5y0LQy9Jj65arKLz3pyFpgUpf8hlBt/MLxa69OQlZp3kONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Kq+Lteve; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718364942; x=1718969742; i=markus.elfring@web.de;
	bh=YcAax4mGY5XS6LXmltoAYPKWqdfE8AQ1OyYhEly7lVw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kq+LteveHoSa87BACGK2tPOURM+bYwl+3Grz0UndoM3qJ5RioideGdKmfmy4OGrv
	 hzSJUGHAQqpV8BUWuHfrijgOZ+2peQEEGhMsaTotfbqMfPLD+UPj5Lnrl/kk2sRTK
	 MuRTS8PrBuHnh7TYsjoq1Pb0DbQDNkh/2+Pe4Z+5s2oTDiNtfZJgtD4eCPuMXPr63
	 KLwKdu3aeGAk/TzOizo3r+a0Tx2RVWkkmJPzoOixO1CdJzrSw4PTVgGw/qzC614hb
	 6lWczaZ5EhuXPTD3WXg5nXd9quedEquFLKgGcUDu0IMOFpewKPUmSA56lcFr8KYVR
	 nTEhlt8vHyrT/WJcMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCDq-1spD6s0NsO-00mPh0; Fri, 14
 Jun 2024 13:35:42 +0200
Message-ID: <36c0231a-9916-4734-9042-7a07f4cb85f7@web.de>
Date: Fri, 14 Jun 2024 13:35:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jason-jh.lin@mediatek.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Nancy Lin
 <nancy.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>
References: <20240614040133.24967-2-jason-jh.lin@mediatek.com>
Subject: Re: [PATCH 1/2] mailbox: Add power_get/power_put API to mbox_chan_ops
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240614040133.24967-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eq0ooUkCsx0n+fQtzujpSvtI+YXXA7MuMYC9dd+eoYl1noa3q2u
 8aplDdEWCX2ZAE4jiJZST4bkHw1JoXUswCdqQiz/HQS4ZZauqaHXeXRAysp8ig2f1fVSINJ
 OnZufXWHXdnUGucrm5vziAwqKpCjfnq+vaDcYCdoPY78q+x0EDg8I4exllvjjdUuJphu0wV
 tHdvWKU/Zp2eG8HbNKfzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q8ewVWtKAl4=;KGsuYjGac8cOmbgYY6kk9QAUTcG
 A81i94SRhWcE4NPlJ+Ra0TI1oXf8LK1aK3EROqqN3xkxDWRaFnmdHBmkZrDg98XMT0OTPQfmE
 4dgHwShonqR50frrzl9SKUCJQxNqlESDSMkwc3QuPBafYTn1sv2eXr1nd/nrf9lJvT0av4HSS
 FhW8ENUiPdabenuhOQR/crDe36117ZPJcoYn050Ij3+KiWxAModrxC++2iP1s7oP0p+Yr/2nT
 ugoqGbOh4Y5hJW8mlPR3N3qsYr10Uc0eq2RhIwmR3IMf7fgf4Fz8MOp+sEIq0ZqEoUCow6UWO
 yz3Co7hHe2uz8XwHzvbuSVaWbuLV7gpkE0Lw0B1z18hMZBu+OPwbtj5t+VJu3108kxKoqCf3d
 w3mWn3K5TMMyiSKlMfZFP9REOamlJF+eDDll9P/SEkU5zDhM8DPEcUT89eE2x1Bjehc4Pfm3Q
 nWZ10gR1E7wDAG82tgOl3sA7wbliCmkIV/HAtLeOuGK9nNcn3BBJHZrr0lwed+p3c/hSyvBzA
 XNd1yz38vVGwR3+/j/PAm3eEhovgEJwuDLfQTmnJxLvnGLSOzR/Ml5zQLh6ewiPj/SuRciG9g
 Lr9j2u7l/oQR/b3278IiDApzrFKJ5Rh/Rf7jlj7oF/3ppOfh0rUCG1sjVy1UDdx18HXxvS8nc
 JQOB8dZ0OPScW/0tx/yduBzBksvJwvgVOyKypkNScEd+62VWR0jfBewKF+iBcE9fgE7ldxvu+
 qGOrLa3LqRJOdkK4x3XsyFMqVxWN98Ya3QlRcIUK5x5JWtmsEPjG4BZFj17dFg4SoR6z1I4Hz
 HQlEAjLuuKJ8tAXgFm5IG3OW7QEdR61mcdWNI4IKgzIq8=

> To avoid pm_runtime APIs calling sleep in all the atomic context APIs

           PM-runtime?


> in mbox_chan_ops, we add power_get/power_put API to let the controllers
> implement them with pm_runtime APIs outside the other atomic context API=
s
> in mbox_chan_ops.

* How do you think about to omit the word =E2=80=9Cwe=E2=80=9D from such a=
 change description?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc3#n94

* Would you like to improve any indications for adjustments of data struct=
ures?


> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Does a dot really belong to the personal name
(according to the Developer's Certificate of Origin)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc3#n438

Regards,
Markus

