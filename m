Return-Path: <linux-kernel+bounces-429417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD39E1C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C634B233FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DC21EC013;
	Tue,  3 Dec 2024 12:14:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE371E6DC2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228070; cv=none; b=X0l23FZvWNbiNB7oH/Qt183sbjY/SpLFD+c1YM5YpHkqcuNsr/5hkBdt5XKu/LPkuUgL0miLjX/OSWRk+6cLg2a82l2CN3T5YWX7yntODXec1HzSsbuWMPvJ7JBxxHuowKNYFKPpsZbAmiySxQLV9wYJIMwCJZOCyNxdRoh4Ti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228070; c=relaxed/simple;
	bh=f+NSd2o6RwWXfufcAgaHbk25ieJl8/sXyvnrwcLfQR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgNdeC0jlWGtP2mCd+sqiY3z8+DXFpfZDNo8ctUG3jBIikzsYTkrEwo7GXeMnLRJxqnenShM82Loromzlay6c8O0N81BAIErz6UFNR7VDreQH7ho+vOF4/JtT8tcTZZm/GA/v7PuLK0sfas38VmeZMf35ax9m/iBZkpEW8prXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EBABFEC;
	Tue,  3 Dec 2024 04:14:53 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946363F58B;
	Tue,  3 Dec 2024 04:14:24 -0800 (PST)
Date: Tue, 3 Dec 2024 12:14:22 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/3] arm_ffa.h: add properties bit related direct msg
 version 2
Message-ID: <Z072HgItfbrUl9K2@bogus>
References: <20241125095251.366866-1-yeoreum.yun@arm.com>
 <20241125095251.366866-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125095251.366866-3-yeoreum.yun@arm.com>

On Mon, Nov 25, 2024 at 09:52:50AM +0000, Yeoreum Yun wrote:
> From: Levi Yun <yeoreum.yun@arm.com>
> 
> According to FF-A specificaiton [0], There are flags to be used to
> check whether partition supports send/receive direct msg version 2.
> 
> Add related flags.
>

I will delay this to next release, this is not a fix.

-- 
Regards,
Sudeep

