Return-Path: <linux-kernel+bounces-372052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2778F9A43D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC461F215E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D9202637;
	Fri, 18 Oct 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R+MWKBkH"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD3168488
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268833; cv=none; b=f5oAOfBMAaP/rIkb9bpN2AFVMpmSmi1T83knz1nXAopbOj0ncMHLubKnJ2CPh9O9JhTJpGhvm/RF5UuC9oYrd3dxQ7YX9AjjN/CnOV0CZKrAALRYDky23Z4Gxn1JgvCg4ZZRrS5w6U5DXijjaVDCbxlgGjpSuQ4RmF5uQl6ek10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268833; c=relaxed/simple;
	bh=yff8jiYhkSJMpQXL7yHQLFBfJfr8es3YLk/AWj7gIKw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=f4PflIRn45tEDOmMoGbjR5KYWX3/jotB6NafubEbuVeRsoQ2RHpqnDuA8dKHDi8vUNIBuYzjYPvhOUXZHyt+oc1tA7H5Jsc/tblpcrrGMA3mzF3S/jP6f9VvQu9QNVnGqF2uQJBZb/mBHjVUb90nGJgHRsdNPvyp/Lj66o2g1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=R+MWKBkH; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729268805; x=1729873605; i=markus.elfring@web.de;
	bh=yff8jiYhkSJMpQXL7yHQLFBfJfr8es3YLk/AWj7gIKw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R+MWKBkHEhqPX7xV7z8BOajmBoEBpzttTrD94F0l47wTcloRsgvElE4TH72XAwNE
	 p8BgAyrZvCsP41GHWg2ngQps7eZgK/pDa/gKn35vKRtO2Ef1MEp5sL2y05vcRNEwG
	 oO+Xw44Rc4MuluYFEFqb7J7yzps/DeAhq+UgZ0gsnPhl5BeQXQlkPv+JiR3KLR7x5
	 Yfyg3yY9kqEd1ntjrRKGaFrbXFxPWbCeMBi66ammxjOm4BzRLeGxnPEbVbgjc0X8W
	 /Aq1A4gi5WCtKZZtr+YY9W+oLGXFyJLAoWgZqoo/5pZ1UL1qAuNo3mZR5mfvgtHSy
	 4SL+3oNRKnH1MZNvpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKuOP-1tN45g3HPJ-00LHyw; Fri, 18
 Oct 2024 18:26:45 +0200
Message-ID: <8e55a150-6e56-4027-a301-55b068471664@web.de>
Date: Fri, 18 Oct 2024 18:26:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhen Lei <thunder.leizhen@huawei.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 James Clark <james.clark@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241018140858.711-1-thunder.leizhen@huawei.com>
Subject: Re: [PATCH] coresight: trbe: Fix return value check in
 arm_trbe_register_coresight_cpu()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241018140858.711-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ybb3Wk5w02ab6Y6rhGHHO3eqEi+Y3+orJ+/k29pwsV7IawgS1Ez
 Qe5xhswHqVr+IJvh7Ny4O/ruFqH+UtEyjLwraG5QhU4U7zKwWigo7CQxIL+kQ9w0cTrau78
 1xVYdXshYtLhcckU1aPtdoZiv/3ETcXrcPjQ2SiQEZqI0yDO0VqYHgwjX5PLH8hsePKzC8I
 3JuUjNZj2c3K/mWr6traQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RSwq4Ww2HUw=;82MNYmwzILVrVse79ovnlPK5rIS
 WqPvvRnAouKd8ijNJaKjI0v5RPrLGLKf92LJaRCHgxM5W6s/unL6q4HbC6FI1FF5m1df7BEqm
 C6hCRZWuC+j4W351G+YJ3ThWyTen5jP/d1PfRPXG8stpYZisjK1mBoJbBGaLWNL1aAvKpR6Mz
 70JQg3FYVokyfX2wPVKy4Jws6j5AFp3dExbUtvGo4CnUOyqW2/PIKbA6PTspxkBUvEP2pYWMv
 4i7uyQjQPVN+TCvyfb9psmiIL4UMoQJKXq+XsyvIk/1F21RsCygnIXiVR5Wzi3nlm+RozSrKC
 YbBTs2rJH/HQoZoaq2QToDLIKUoaZKhNO+foRaxlFxR/U0BT1MrcqUuJMpuE2i3dZF84TGnpQ
 WP64DN6mMGW5dm+JUE/s2ae9DuRnqBQZXOQ4uADHzP/y69CdtE60wY9UuF7YzPKkEDwOi2tif
 piPL0oRvhib+ZHNI2S/6H1QhLejNwwaxw2AdTzmotZ15ycmrysmBzgT7VxVqFo4IUEDKY+Ek/
 bfEkSDrAmiyORtPLkj2QQwMaE2Ui33oE6tBelf0KM86inGJJ8G98fBA/tn+xM/UCvmbk1J48k
 BORXE67I87PCvFQOqHqdEW/12gdQVGGKkQHuBj8xJhLq0yKLA+srp4sbP0h7wHM7qBI6mIuFZ
 2Kw1ii8d57H4RP464BS1ez/digVVRTmQxoyQNvhyeskA7HnWiLfJeUP44bnlnzwRJ4fMfrbPl
 /zsveCjOUpVKwaZQCZYKiV21YTaM2e488k2ZpDyL8bXTDYOi+iZOO8PWTaJ1PsN+/axSgAaYh
 mNb5WP3+1BKZwZr49NwaubkQ==

=E2=80=A6
> The IS_ERR() test in the return value check should be replaced with NULL=
 test.
=E2=80=A6

How do you think about to convert such a change description into
an imperative wording?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12-rc3#n94

Regards,
Markus

