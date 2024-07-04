Return-Path: <linux-kernel+bounces-240593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B10926F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD55B21CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50E1A08B5;
	Thu,  4 Jul 2024 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uTQpUHlb"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A61A072A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074405; cv=none; b=c0VYc4oPExdKcrzz7PgFhnFYtQOOSueTLoAb68SWWIQezg/MaDvZ0RyaTKMb8KmK6BmSByW7iPelGLtyQj5aJcdsIHI00vjuS4ZN8Dy+d1wA/CLsdHFVHdIMcYGzQ7SR4SfL1WNqzCKFqahYdcf2bdX/fo5jAoo5fxPORy1g55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074405; c=relaxed/simple;
	bh=uCF2EB4gbFocwquJvCdIKzAh9CSf5NQdGLskTgx1PY8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=euVahMYFUtdePRKh1FY85Ig0dLhOSvsnjUz9R4lRBIaVgFZdybBfjbImCQIHaXmtfAbfW5OlhTHFSsSSmo3Oco9qYEecQ1/6GkszS9fBtBExD3CADQgpfulT3IX7gK2tljySQc7eceVjUueKTmPQlZ2jwwtnXchqihbY4A9ouIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uTQpUHlb; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720074374; x=1720679174; i=markus.elfring@web.de;
	bh=uCF2EB4gbFocwquJvCdIKzAh9CSf5NQdGLskTgx1PY8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uTQpUHlb8ZnUwyNUGHCsQCMUJLUmJxZ9tuEb2AjrOyOJrTrb2+FU9gIbWnY8VdYs
	 W1+PE1YQGL9xT41AC9fjiuy97JY2WyeY6Tr54hBVF0OlrCV96KCgF994pYXyr1xVm
	 ZcAiSGkPGCYdgBw5pP++BB8iBpOFWDlfFGW9TFacYUdstLlrw1Fcfn1fBeJVtz0qI
	 MYMSUzjTdOxLtMu9YNlaVo3Zb0JVQ4UWhN3o7FWTpfvNS2ryxwikIeCFeVFgFZzXR
	 oGJ0J22lUscFE+gYVTL84jQ94NlBmp64Ausq9xVogWWM5HULu2gtj5pexUpv2K1bL
	 sUn40UYKIVHWv6MuWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Lg-1sS1sO29Oo-00CnbU; Thu, 04
 Jul 2024 08:26:14 +0200
Message-ID: <2121fd23-5cb8-493b-bee8-0c7d74bccfa9@web.de>
Date: Thu, 4 Jul 2024 08:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daejun Park <daejun7.park@samsung.com>,
 linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
 Daeho Jeong <daehojeong@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dongjin Kim <dongjin_.kim@samsung.com>,
 Jaeyoon Choi <j_yoon.choi@samsung.com>, Nayeon Kim
 <nayeoni.kim@samsung.com>, Seokhwan Kim <sukka.kim@samsung.com>,
 Siwoo Jung <siu.jung@samsung.com>, Yonggil Song <yonggil.song@samsung.com>
References: <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
Subject: Re: [PATCH] f2fs: fix null reference error when checking end of zone
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sziOUlnAjE0P9t6Baaq3Q0zyVJT9942lH223iRRgb2sewW374dX
 f9eJKFIqVlJ0E3PANv06WVqLvxcx9jP3cF2q3B/xsmvJMJ+Ym7QI6mbIlFPnMxa4w+PQC3C
 NoF9KfCkfX6dT8w+cYcpsbYvvYTB3bSA+MKpZAPW6GbZIfvdXPtqtllWkR+0G6NUlE8LHzg
 2LT3x/v1BNYmR9zRHZ3cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s5l9pmtnMnc=;lJXEK0apfPqzZOEwUykEJjDA8md
 V9sFsO/B0b8g467YFV0XoCUMZYDPMbZ9red8OIv5PBYkljX19iPJHG/YcT04Iy7VfW+ezgtQa
 28HNOwwqG7oaifiEnbAWdzT0gjtdH71Q+RlHYopVIeDEoObUR6Tb1liEvsqy7uEbfeqTo67zt
 AAKzxSZIj/HEiJ+cFzIrsiLDkR7wxfYvR5b9pzoqsR48Jto/BxGAgbO5iULYezSAByL4UjTfv
 BNNvx8KXXS7GO0SNwXT1iD6C8ZrSd0yQlySk8Ed98oqcpZ4p7IuMVOy+Wyfe3T+rbDFGLaUz/
 0lhL54kDNh4wwtHdxjzt4K9XRBXtwim7GTD/K7HRX3e8rJcwjnA12PDcssauQeeFko+sZ7+Sl
 8IwBJXayMf6SonjYxspEHf3S6Ur2GPdeV64WEHh4Ox9ePsc+Sz6dcqzVT/z2O8ZHoP65nXnG7
 HSxV7lpqknCCax0BWOSO760r8cVkxBseCXwt0ApMtGk/QCGY3fceLQpl8b72/9u0Bamt0VLdD
 GkMn5mXbiJiaRY7EXNLUstRxApHaZuXeDK8aK76cs2GH56wEGaDABI6E1SqMTQKaYQaAhbxA6
 fK/gITSDjvJbra0BctW+K2nJ7wVfBGPrPU4C0hujx33HjYUu3lWZcFNxlqRS+nVjbInJ1mGxX
 OFvJEhP0avtM/8kLxjwDIuVOMdz9v2aRZlZtfVYBIcfQbP8DExQo6Ft0DgrQcZzCfbM0vQ25Z
 fL9P+V5081DSXDcZ2YOopWWe44Jr/wqUrBrfuNg8/W/DTFWzeQFM7wVy4UcwFSOK9vaiA3tNV
 mZgFNf6s5kBvYPIARhX9X7iNvF/DikbpyJYHRMPZ5W5qQ=

> This patch fixes a potentially null pointer being accessed by
=E2=80=A6

Please improve such a change description with imperative wordings.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n94


How do you think about to use a summary phrase like
=E2=80=9CPrevent null pointer dereference in is_end_zone_blkaddr()=E2=80=
=9D?

Regards,
Markus

