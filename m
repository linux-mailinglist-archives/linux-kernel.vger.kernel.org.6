Return-Path: <linux-kernel+bounces-199387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251598D8672
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C0C28159A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83774132123;
	Mon,  3 Jun 2024 15:48:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18650F9E9;
	Mon,  3 Jun 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429731; cv=none; b=AxyAsVTlmWqM6SzfwYlCyYs0t4vaAaShLuzGma87y2PV01B6pXo8UIJcDSLqUS8jCnoeQQr0b4ozlU6ovBnIMxZQSMg7WMTbHTMn8EvTbqzGuDraTgkWWXQFVFLhUo4C0bBLOs6YqsXSp9O1zRJLNhYT/JI272m021y0Ok83yV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429731; c=relaxed/simple;
	bh=4rbsSGNDm5qzBO6PTsa/9HZMeyJaipoakrd6MQnvl8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfFTevZ8KHzG0Gj+YP9jbzlZf5yQ4OgcSVNK1DrZvqaC6Aq86lJbqNRDds8TGxW9OlzV8ZImtUbG3qGgJBYbIgJf1jnpT4HKGpzn+hm92FAqtA7Rxfa8eGEaiANSIxU1VuERLrJfGF4CLSiR9DkAtifNkiZKdSHbhdr8FRUcMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CCBC2BD10;
	Mon,  3 Jun 2024 15:48:49 +0000 (UTC)
Date: Mon, 3 Jun 2024 16:48:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kmemleak-test: add missing MODULE_DESCRIPTION() macro
Message-ID: <Zl3l3yKOidyA8yD5@arm.com>
References: <20240601-md-samples-kmemleak-v1-1-47186be7f0a8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601-md-samples-kmemleak-v1-1-47186be7f0a8@quicinc.com>

On Sat, Jun 01, 2024 at 06:05:00PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kmemleak/kmemleak-test.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

