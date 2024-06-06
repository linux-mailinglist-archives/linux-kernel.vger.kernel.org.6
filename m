Return-Path: <linux-kernel+bounces-204152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365978FE4D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4CE1F25477
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C458195397;
	Thu,  6 Jun 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LYtv5Z21"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A14D3D56D;
	Thu,  6 Jun 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671722; cv=none; b=HSkEkAHtFTjRgi9kL8R4byiDqFXxCwkFiPoQ2vRZqpwR9ir4/ZnJSGBaeOzGjLRmzcno09TYlDSrnXxg82Gt5zeNqPtoozhnZakaFXDJfrZ9MxVtCJI23eKvIzOCGHsCa/GPjdJ+HRF4nOibCho4OS9v28Z4nrlrnH9uGa+jvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671722; c=relaxed/simple;
	bh=62CrMwnBsDesJfBbj4JdA6nLwnTrPFPozSa6mWTBTjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFVeP9PmmO+grqbAkxkfyo+vP/QOU8EyYjwG1ThPD/A8SGAaywV9MzuY+VsJpSjrbY2fxcbjnLxjQaM/OXqBMzv0uy1do1RNm78QjKb29kAVqv6j4GZ0qM1ZeFL6rq+bE+4gQYaot4pQgy85Fzjf1/wWjNWuOCUkPuOaP51pTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LYtv5Z21; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717671696; x=1718276496; i=markus.elfring@web.de;
	bh=fbrojDn0VDdn0L3EW1XYF97yJqxtpi3UOK2VLs7ulp0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LYtv5Z21OpbjF02YgCTqGl/K15aq6Hez0UbRlIO5aaBciJaoAGZ1m8Iht+qhSYEV
	 tagLKVk6my66ej5CfUCVJDAddet96+95Ln6IU1CHLAro/V2sPVD0c9V+ZL5Olr8fM
	 WWLNG4qfVMJj5Sjy9CTTTiPJr1Pganv6r5ElLrHsxVErLpNpc+9zsgcaOIjLYgVNj
	 04t5XAwi+37ORrya8E/lfiWTgtnlqSFMrg8zYpkgG0Vna2mujmahCagNQ4kZ/uUln
	 l5Qoggeyb4wtd7DNedzDZ9aqSPW/HdBUUfIoA3Muy+eSqeOVy37auEFvVboTaKQDI
	 3aWB0nihTdszQmwyhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14ta-1sQhFd3w0Q-00rGUS; Thu, 06
 Jun 2024 13:01:35 +0200
Message-ID: <204dc14f-1f58-4425-b613-85538eb4d947@web.de>
Date: Thu, 6 Jun 2024 13:01:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: usb: typec: anx7411: Use scope-based resource management in
 anx7411_typec_port_probe()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Xin Ji <xji@analogixsemi.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <889729ac-3fc5-4666-b9f5-ce6e588a341a@web.de>
 <20240606101757.0000331f@Huawei.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240606101757.0000331f@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+TjG99r+XNmlKF6SwclUrVxDdMTNQkCcRDjGzvh01/WEkKXLCTs
 8SyL/Aay6KAsy3sM1C+dyMCaVelTWmyZFONT1jOsovzYxEh5i9M2KYJ1uVTqqbnaZwfvOen
 W3Bn7BjhhjqRhGrF9jxxl05jobJ3HFe7jAnotPL3tKKe76hFpb+9bf3epKG2wMVRcZyD3IB
 +xQf59yiUk7/vijNhlZUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h0TlJMfNPT8=;buw75irrEL0dwYIUtjk0vsyLbxT
 A4i5U6FotW7xRr3WUT/bv7tNybBAp0Y5N9UJEmIyPSrE59jK8eTpBQhZ9+GD6n9nd8SlxyP0X
 ioS+hdwR3MRP8l/LUvxWlnBDAMj6Nld1Mwm7apyVo/ootiSXSM0IYWA2UpkP/BQaeSmxb/+OU
 vDFOhom4mWhGpoFnRouiJxIBk4bKmYwst/Qof9TBgrDiaZnh2nx6tpeh57sASUHtucPDZxn8Q
 DrfmMiUHa+kSppYnRueQ+4UPtNKaaYHLP04EdSo7wdXUiOXs2bHiICpF1V4fRTEw+2ezEfo25
 OV1taok/oNcJCeictql5z/DHrlXMIsfF2NP6fR+3u5/g96S/VijY4/0wt3dlS+wj418jSN05b
 x90G/7AH2KSQmbeqiwgxrkdFXyzddI5/sh6dUj65znRoR0Qns9jYJdJYnPKyOpJd8XytUrGIG
 0qHVMlO+WPKa0ppXmaQW8gQ2sdHvK9cfvEjii1zZYGO3eizaO8sFVdPPvXtiPCNEEoymccG+K
 LLehTl0Zc2IxbdyKkWeRPN1HrMdNY2ifvGegyLKK6mY5cV9V1WvrDd1K8pFY+Y1knNf9xx+8n
 0WWo/NdtGG/NXDKLn5Gd6t9/Y6OwZM88izNtPchF7dhJg3qOXkWBRXijoIVp4yn78gYsivOeo
 p8+LAZRpNfiOvEQ4w2XmhJVOdWORZo0e360um7F5VvHFbsiIksRXw66dYUCghf7BG595KZCSP
 v3wTdrMuKP7eiOuCorDmcY+xOKZGEqD3hYIUcfI+El2E/I3nT6EM//mML/PKEDqHF3KShUinF
 u9VEkXEPqFocJRzwD5vV1KsFWTJNMeIZRWdvVVQjWnePo=

> That makes it tricky to use no_free_ptr() so I wonder if this is
> a case where the old fashioned fix of adding all the relevant
> fwnode_handle_put() calls is the better option.  The __free()
> approach doesn't always fit.

Can involved development concerns be clarified better anyhow?

Regards,
Markus

