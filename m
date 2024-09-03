Return-Path: <linux-kernel+bounces-312731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC52969A75
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3DE1F240C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF51C768D;
	Tue,  3 Sep 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Myqmxq1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0071C768A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360145; cv=none; b=MdqB4GCa8gB4bs+FxRH5qixs8Z/p1eunb+WXuo06zA6P4iOvorWoj8DmkfzndPb+zBoy2uSQZMYCApzoodIJOpaFnPQw3MWkWF+44MVmTpXEUysL4/mLkoFhIcE8gGeP7/EO7L8AvZV/FUJWvWX2zhkaF1Qzd9MSHEUO2npg9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360145; c=relaxed/simple;
	bh=R0igrj5/lJ/hmXkhdDNojvvLZd69DERv1nMB/5xk/FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBO/Yiuhyy3drlJQAQ/egnJU89jUaYs4zRuJFFpbY4Mfkb1jpywaiIn5hrg6nGncuVaFz3U6l5s4fhMUR8FRSG3Q7uZiyHfh1AoCzEc7LOVqbqI9cwzxuZ7hjyQTnYKZiQLm0CqSrfntZTSeiywUFAiXIuPdVnxKXHFq/efR5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Myqmxq1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BADC4CEC5;
	Tue,  3 Sep 2024 10:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360144;
	bh=R0igrj5/lJ/hmXkhdDNojvvLZd69DERv1nMB/5xk/FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Myqmxq1owhNoHbIhVhdxJYnNB9RuLXiwkjKXHwLRo9qlT7+QC70/GweOUqVq4x0xW
	 uCCotm9r5n0OLaun4ZNGgMD3WvYGC6EokgDnalKOG9PUdKBmsPQnnbVnkhcHcmlcx7
	 IMDiTqwC1AUu1PG4Z6miJlaecP8VcHomu7g9AiwM=
Date: Tue, 3 Sep 2024 12:20:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] nvmem: fixes for 6.11
Message-ID: <2024090351-monument-hydrogen-f495@gregkh>
References: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>

On Mon, Sep 02, 2024 at 03:25:07PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Hi Greg,
> 
> Here are few fixes in nvmem for 6.11, Could you queue
> these for next possible rc.

You forgot to cc: stable on all of these :(


