Return-Path: <linux-kernel+bounces-435244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF21D9E74FB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB992818CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA97207E1A;
	Fri,  6 Dec 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="A3keaSsg"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192941494D9;
	Fri,  6 Dec 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500706; cv=none; b=p5u2GrPdQ8DbystFrgyWqvYjx203ikDed6d4+D0xBFEfUvtvYE1BDoi2p6rWgoD/SDEaoM20uYTk7EUqHKLT3q1RHeECafDVmqYp7pQI+/ZpepFMus2mdddR8esuHGh00ZNF3MYL9LfeYODMrcq0u587+lcj4es6bvZhHgUhdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500706; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=GwnqHWErcRi3O5ZzEWegzDAfA37WZNRqP6i1buHBIgVohrOtXXoCJFa6Cxm7/hO75oCoApjiwIaG5tBKPTXjX3id0I+uSWGT9zkoLmwGZfSxdDUdSoHX4AE60xbvmWpzS6zIefJuOkrx8die56vf3tSGdkXHxFbPFHvdDTkLFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=A3keaSsg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733500701; x=1734105501; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A3keaSsg5aPKVNtRJ1Qhsg8V5RXYpajaqNooRdYiDS7yIQJYzTk78/BwVFmWf0Rw
	 4yakfQ621jARYHZaY8o/MYk5PVSwokGO2n7h93NSCL79cYDL8IwDL3sGXjo0irXnA
	 xz+U3wLi9ZIEJ7v0zYIpnP7peEbfXbR+feAAmBFGXoYBrJbc1+mY8yjeUqwoWelQA
	 uQ+63dLV3ivJp+ennvK+kbG9HjHp6uX9kyoLeYYFdjC/gvpjtzq65V4GrlM1NVLQA
	 HYS5pqhy2YKeHZVRrWXr0mu7doWlNL/ylCJnz/Lbac7FOi2pSyx1mcaIdc9fVv3Bi
	 hmgJY2CdCqwnL7GWKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.32.130]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS54-1u3Orv25NK-00afU7; Fri, 06
 Dec 2024 16:58:21 +0100
Message-ID: <aae36207-0f8b-4339-9950-0748f71ff9fe@gmx.de>
Date: Fri, 6 Dec 2024 16:58:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.12 000/146] 6.12.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BpsSZVR9clMl4kBGyExOhvPVNyM/br3HiDiz7e+ONm5q16H/3NY
 E2SjCZ2Cv8dfJhQviKOvws+XsVssOgqe6j6J6pLw9PMMfF6FlN8PiAQCK7JYH6oCa+elhZc
 tWVumF6jIbzwm5OUrvTckxjLUw9zHBwFiNHvzqAE9GthCIaMGvGS9ybr29AhIihtep6oKcA
 NT148taI9KL+p1aZpnNHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p/XASidJ0eo=;Dhq0TATqKh7PBpVKD6Mp7qR9s8b
 PhRZ8Vs187gri7SB+ky151fd8THBgUNfiteuTHJHHrx3mfO6LoBXs6RcviwA3rqqFb8z8P8CM
 H4ENKw088vsS/OKgcxzdvJhn8zLEKRW5VglIFcz/8emi3J22A7xwp34xS85bIYosbSXSd2Moe
 HwypKKZb3mw0wkeFxXhsuhqMBaDb9sG6UySi+X58jlC4wPif3A3cGDIVaH/krfujcxTfFoaGE
 Bs0D0VvDo864AjdSqX/aeQ9IBs8zUQ6evXDPMUNkVRi0cfX+1+FwZpqGtGazc1PICESZUfErC
 HjhBY6SXr/sUKsjEP+m7iIVyGTu5tju8wUhXQ21MmfiuHNlDd3jId1ssGxjBLPYrXZByXxYyI
 nKnIn4/NC6fopuPigj++witVgVZeYhc4shwrOlIjOWZaqj5nfsiqpvt8tTSCFHkHjXjH3oNhF
 r8QHlM6NKYlj1//uRXxn9Bl5KXq0EiSf/Aswl8muHMHsLzZIwm6+0RusdlDfQrcGL9LrN5w56
 saWU+tIdJLtvOdmqBYMTKsC+R7xHg7wfmmi+G2rQnjOlm3JdXTrzx9Mx+0kGt2/JQf/eoBPLG
 SKMg6ZBq0xf8JfAKN3vc3Y54at+sNDhYK9XtMdw3ktNLPNYnEkQchunXOrOdbyJvFoRRAQGQa
 7CCxFPClr0ckKQV+mZq8cWTjyiZI+7Xda0tr7JNeaTS4ebaXBdIy52ip/EXxxFegMJO/9svcl
 w2fO5tER7s1eDhlg6ATvO9+KGtcgCvFWtl0UA1TbW3j4b4PR5wU9vCZijyc8fb1emX3eELesK
 oJloc4LhMb5z0prINtDGzt2zqYijkoXYQwPWtRo1Ar+EqcKiMbgEEgEKvOPfK2PRVh1nVeFvA
 vQO0XFihHG8Ges/oRkFg7G0H+Rl8lo6tuNjpw13p5/7WYPlPq6KcdUOKMYa9nvL4RFn4yABXH
 /Gb+9vIQcolHqDHuldQfu5u+Z8BNmXJNNx7Xk/EVHZlsDLw382QZlNuzygxrtBIaMoEY9acnX
 ttTADvwTmO/hx5Y9k19iYgJD5OzbMz28DD6vjvIJj5brk+YNgJDhVVtPk9mFUjqg3fYem5YSy
 EZdQaEAIU=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

