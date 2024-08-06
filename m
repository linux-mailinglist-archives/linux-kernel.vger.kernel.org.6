Return-Path: <linux-kernel+bounces-275762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A32948981
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03445285A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0671BCA1C;
	Tue,  6 Aug 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tUWonMlr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0A1BCA0A;
	Tue,  6 Aug 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926265; cv=none; b=LNqPiRVfZ8AVILt3B4I8WXA7PR35fqN63d9OaiIlzMk2ffqXemxfzs1SpZQBIJ9wDe9wlb4C1GttCWMFvPotaD00YQJiDK3eSCOGvtJBxos4ii36r7Y/BPEARlPz4L/ufJP8POQRRk/gFJRcEOuS5HhcG+UqLsAQ89e/Pe4+ggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926265; c=relaxed/simple;
	bh=3bxoBjPRRGRL6zztLefPWhgp32ED/alXOWCFQBOTLx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF9is2G433KDtzjQ/eQJGuzUTAf3M2YotBp8JdNJZlTI55mt/stIL/bIvq8s/XbW2JzQCNXstkK5uNYApgcl8lCbZMHB77tSkXzvefst8T2F/SZt47Aaf3j9PRWrOvuUxgfGXfOO/YLHu52OjuDBAlKl5KAuxW0nzfzlcH/5Q5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tUWonMlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3D1C4AF10;
	Tue,  6 Aug 2024 06:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722926265;
	bh=3bxoBjPRRGRL6zztLefPWhgp32ED/alXOWCFQBOTLx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUWonMlr733z4gawzJOT7sksJyICPTwv0zSzruXOHWEoEcNQcW82LhoHe1ovTF3g8
	 7baDdk2NNEJhzaUChSHZXP8iRxsm5y73ozvuTu6lvXeBXpEqzqQBKnV9EaZK6WfhH+
	 eYHyNoiswKE6kfnWx0Py9nn2uqQiZJk38k8QWnW4=
Date: Tue, 6 Aug 2024 08:37:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wang Wensheng <wangwensheng4@huawei.com>
Cc: lee@kernel.org, cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org, xuqiang36@huawei.com
Subject: Re: CVE-2024-41008: May I get more infomation about this issue
Message-ID: <2024080638-sedation-swivel-bb9c@gregkh>
References: <20240716080357.2696435-2-lee@kernel.org>
 <20240806024611.130463-1-wangwensheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806024611.130463-1-wangwensheng4@huawei.com>

On Tue, Aug 06, 2024 at 10:46:11AM +0800, Wang Wensheng wrote:
> It looks like a feature from the commit message of the fix patch.
> And I have search through the internet and get nothing about what
> issue this patch fixed. Could you give more infomation?

Please ask AMD about this issue if you have further questions.

thanks,

greg k-h

