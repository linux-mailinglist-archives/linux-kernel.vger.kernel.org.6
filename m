Return-Path: <linux-kernel+bounces-221720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654CC90F7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722961C21683
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055F715A4BD;
	Wed, 19 Jun 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uN+VngO/"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FCA29;
	Wed, 19 Jun 2024 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830125; cv=none; b=EZ5wOcx6tjpks8Y0FSq2gRtyMx9t5GAem3yDRvFMAAtaIOM9ETI9tIno0nkKITd3q9KzCNHwek415fFkpBBYVIql3Y6nLqbcVcLyPJpfZMl+s9hv5Gg+G8GGVprXsHum6+wUdEFRcOjYkAHQyX6B031aaSXuKzvVuaZdFoL4X98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830125; c=relaxed/simple;
	bh=BwOtPCpk5WvqrRl9zBjzcE5O0zE6nZShSGAYhIz3sdk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WnMe48AvuZ5uTv6vZzxe/8lAKQWigrC3eMJUK0RTSp243KKzRPggGR+3Q+nj7NTa9JvA4VCybxStJAtwe3UxWZ+6SrxFOKGXhKlmddTK2h/wy/Y/KX3P21xmfrGNjLYBMsLd2wRVyLzcdPEmLp1MxdHlaMSerJXFYYFb4ySZrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uN+VngO/; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718830107; x=1719434907; i=markus.elfring@web.de;
	bh=BwOtPCpk5WvqrRl9zBjzcE5O0zE6nZShSGAYhIz3sdk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uN+VngO/GYoooWhHhRApfvgn+EYn3SPZv1nogV5lNaz1m231wnTUsrU0rJOkCO6/
	 ep+M8uaMHxuQgbn8zLyve1n2RxTG5UblSVtM/Qn8vCkNfRyt1CeGb9DoVR8wdXYCP
	 NgyP8bm3CFSzK1YS2ayERAMcsF0akmS+dG5Ur0cpC+0xD9SFGyfNLlRg2KbDL9yJJ
	 X1HnlDE512EA9PW9D1rmNUjApqBZsakFO4mlyAQXywK5l2BLNUzI2wAeuZgoO9DGz
	 5kuCzuSye8Gvp3C/t+L9UAUV1fizdjhMAO6lV6Cdg7fGfh/5a5wK5IkLKMzNzMrE9
	 BMFtG1F9K/HmDQjhaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1sfOx62RcZ-00g40C; Wed, 19
 Jun 2024 22:48:27 +0200
Message-ID: <78ded683-9bf8-4f2d-9dd4-877aa86e0e0b@web.de>
Date: Wed, 19 Jun 2024 22:48:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hongfu Li <lihongfu@kylinos.cn>, gfs2@lists.linux.dev,
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240619050358.411888-1-lihongfu@kylinos.cn>
Subject: Re: [PATCH] dlm: use KMEM_CACHE() in dlm_memory_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240619050358.411888-1-lihongfu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vK0eUEJAxgUDFnqpljS9QCoILTzvocES7UFEaaUgw8sZ4pLGt0k
 tZPBuxK88lguW5frrCqm6I0hkE1dqxg02O3nM3n73kA1ltZCluyeLl+6eBjMHI3XWKoEsxu
 MV6rvDTHdtu90DegnFO1ROeHdioyukmoCSxSIKcg+IGrHaSGMT5LEjjTNTp5DEQocXR4Z+R
 LbG/YqD4W8va8u2eXeGbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S294w+tx91U=;gUc+2oNGeNpZcmYUwKfTDFz2dhm
 tbf8wjaCcgrpTbPtDa4Gef2K4AXIAutSCdFFUpH6qf6EnmN3t8dtTjrenfc7aKurqaBpSpSik
 gM1o22cpcAKXdGFK4AIEKpL0YBAje8U2OMi+dwqPLNSy9DZKFjMjhesDFrsOaEXuj0IT2l+e/
 /q5w75qCne6IA6gYrfCDlDQNHY73QqSbOrzgjeS/CObsrsAhu6z235ZJU5WK4JsDLxaNyFewu
 +1bV4Ml0Zl70n/LfM5CuD1HXiCygDFeiy6Zg96BjEe70rGUPXwavQBS1QQ2SthzEhfiC3IYUM
 ohOosE4d+JBBnFenvRQE7PelUVyyOeXDA3oDxtrRhb/oLk5a2gq32GMX0GjSznTjeDy7M/7n8
 nO7zptf+7dJJaE5Xm9TpIdtrl9UamUtu1GFuYVlSXN9Z/bNOrNvL5+oG1tkUN8QJ6SH4BZ5bF
 WCo8o2Lr9VTzZz6qQW7IkFXfWsb+VbAGWHQYrHajI3FSZ9vy0zwzL4dNCCHjZPnMdD8Gjvbnu
 5R31Q8U3wO8IVKmjQMVb/YEkUSpJQxw1hsAPgLWoMEcE7ECVw3e5YIvKL2Aevzs5liTYjT4FD
 5P8K5wwLu9d+P1LMAGerFsnPzHoUWlWXiha1E0xUUV9ONqlUqxK4kTD/+VHO8Wkb3JpavWqvX
 LKxXRj2QLqCQqUl5TFlgXKvTVMtP+cxseboP3meMmNBMHvdB67B9mjGAbHt0dN2h3R4+FGzjX
 kzm2J4dfCpHX4kePuc7TPoz9M3ZB4ZZj/WRwNbkmGlBPOKbIrISsHfDM03xEXR09SrDwEttml
 E0lkc9okKuQZI4wlDuxBFALSHngqhu53MlAnZK2fHwfkixlUIDcrA54tFtJDgfsV5T

> Using KMEM_CACHE() macro makes the code more concise and easy to read.

Can the three passed name strings matter still for the identification
of the created caches from this function implementation?
https://elixir.bootlin.com/linux/v6.10-rc4/source/fs/dlm/memory.c#L27
https://elixir.bootlin.com/linux/v6.10-rc4/source/mm/slab_common.c#L362

Regards,
Markus

