Return-Path: <linux-kernel+bounces-551251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122E1A56A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4403B143A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4809821B9D9;
	Fri,  7 Mar 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="wQzNls8W"
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379F21B9C8;
	Fri,  7 Mar 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356914; cv=none; b=NSAkTXxGV9zmV2My7NNm3F1ok3P+wEXfuVGWdttDzecEWJXw093P7oXiwAlTbE5oj3enbcipOyUbNR9Ezvqyu0XvFAEIb4KNZr1QBxEqz+llprk956heZwCdSKloFguQOcQt1vuNDpZYMPkThRq4XV53LSAUj6+5EBmgPks9pXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356914; c=relaxed/simple;
	bh=/QBb/V2Z63Bz9TmEL9zPOtYOwuWhd0fcdp9PQO5qmUk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa/FpfoVbAivdbaM+4LCRRAdgZPaPm2MXUY/fnCbXWWnzVmgbpWXOhu3FGa1fzz/l2UNNcLHaRyRJbW5umUDttVa7+nL08KrSspOCF4ecbp1JnjmMpClxUXIr97CYW+jTr2wgpp8qeNb9qu2L3J2X7A76MWPw/44/R5wWFXH+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=wQzNls8W; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 7 Mar 2025 15:07:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1741356442;
	bh=/QBb/V2Z63Bz9TmEL9zPOtYOwuWhd0fcdp9PQO5qmUk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=wQzNls8W8KbPfhs4Jnb5WM16tL+MKT0DbFYDLqcLNNldTr6wRVXbHglYCXh064Kv4
	 f8wV5UR65/IWOh8hD7Q9MASWjIWFA3aJdvwj0vOosHLZ7T55nKPrA2PiFh13F6W7/S
	 TjKK5tk4XNq8hR5oEgFc5g+BWNkI85HhyhrnytiCjwWr132xvW+92nIquBsHTrs4/K
	 k4vuUEcnMl7K6oIi06yhWaZpU5OPyhh9/5yC1jQL/b/8SZPsfSKF9lK1C66nxcHsO8
	 tow3fy774xjPZW2zYnG6Okxwv6t9ZRN9u1mvuykr8Vwx/3LX4M9tG+me61gWol4QA2
	 ztxAfv95o1oVQ==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/148] 6.12.18-rc2 review
Message-ID: <20250307140722.GB2770@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306151415.047855127@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306151415.047855127@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.18 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.18-rc2 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

