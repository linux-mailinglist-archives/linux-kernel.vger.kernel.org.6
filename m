Return-Path: <linux-kernel+bounces-318428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08DA96EDBD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756871F21E59
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D5015821D;
	Fri,  6 Sep 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metrotek.ru header.i=@metrotek.ru header.b="PeRsUgaK"
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
	(using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF942065;
	Fri,  6 Sep 2024 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.18.215.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611028; cv=none; b=fH1QKxZLNbKJ7tQXJiY78LHWHwvA9J4/xhAw/goDDbO2fd6c2dXyU8mJoMg6jKY+c7DXnXaaSV9xfhPuKtpd6+l/nK2LCUwLaH2n9wmBmXD7ajIxbPPvMrB6/zKv/OHLoiQ9thDmvPV+zthPk24DpN/zgUuDeJiWoHop+xnvaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611028; c=relaxed/simple;
	bh=PW6onf9LcajVOoQ4Hh0om1kDuEKqnohs+XGu9TUH8S4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T+RLXN7Zy4TLDNCJL4VNQnnsFnZIFU8Jstid0R729vSGtq+8JyqwgGXiWcp9hfpou/u6y3dGj3CGD76Sgtitrv0zSFTHTZn6b6iS716Ck7BpHTdv25HK4m/2eTu2yrE8LScOhChOSsyslC1TB69xgZ6qlRGhRI0HzHLZgu/Gbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metrotek.ru; spf=pass smtp.mailfrom=metrotek.ru; dkim=pass (2048-bit key) header.d=metrotek.ru header.i=@metrotek.ru header.b=PeRsUgaK; arc=none smtp.client-ip=178.18.215.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metrotek.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metrotek.ru
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=metrotek.ru; s=mail;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PW6onf9LcajVOoQ4Hh0om1kDuEKqnohs+XGu9TUH8S4=;
	b=PeRsUgaK+zG+7FJpdvAin+VNsXHkYinKk586b7jzCPaiecFv1mZgAqOXnlHGyhwHThSiZbDLRM+wx
	 x1g/ZAXUbnnbIN7nDkdONmKbXZalIbK40BOCP6ZK4m51/6zlVmIZmXXeNtyOrd8dVhc0/2vtwXoWlP
	 W8v1BDzKTzy0B+cVX0op5kYrGohzPWPFwcFr74HkFivyQ+604BFMruivzX/JUOhPz+7BnVv5cAdpSq
	 +BRAskyfeG7F0MPjoL14DAfGgcMLtmTGDIRM1bqF4q1Wj6BtgT6uQroamVkux/ssxzrpPlgAwO0/qZ
	 LVLK3M6qlxqmRjzWSZ8jDQvGS+EzKjw==
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost ([85.143.252.66])
	(authenticated user d.dolenko@metrotek.ru)
	by mail.pr-group.ru with ESMTPSA
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
	Fri, 6 Sep 2024 11:23:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Sep 2024 08:23:28 +0000
Message-Id: <D3Z21TAKKE4R.7AQ0T9SOCGOJ@fort>
Cc: <pantelis.antoniou@gmail.com>, <nava.manne@xilinx.com>,
 <radhey.shyam.pandey@xilinx.com>, <austin.zhang@intel.com>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <system@metrotek.ru>
Subject: Re: of: Status of DT-Overlay configfs patch
From: "Dmitry Dolenko" <d.dolenko@metrotek.ru>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
X-Mailer: aerc 0.14.0
References: <20240903104608.184988-1-d.dolenko@metrotek.ru>
 <CAMuHMdVuJFRrHAR8Q+HkXbaf29TaUFgvxYY4Ua9xQ7mGZoBsnQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVuJFRrHAR8Q+HkXbaf29TaUFgvxYY4Ua9xQ7mGZoBsnQ@mail.gmail.com>

Hi Geert,

On Tue Sep 3, 2024 at 3:35 PM MSK, Geert Uytterhoeven wrote:
> I try to keep it up-to-date in [1].  In fact I have just pushed a
> rebase to v6.11-rc5, to fix a merge conflict with a recent upstream
> change.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers=
.git/commit/?h=3Dtopic/renesas-overlays

Thank you for the information!

--=20
Regards,
Dmitry


