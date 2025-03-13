Return-Path: <linux-kernel+bounces-559747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC63A5F908
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DA63B29AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E7268C56;
	Thu, 13 Mar 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu4VbXWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FCB268C4A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877459; cv=none; b=s1gIxwlgzEixmCfk6ZakJeblofXANqTJdBGeSLx+9rbrkj1tNt5B4yOK+le9m14I5gxPaBirUOgy6mCyMUBqTHzp+6Vc0NakB7cwVlpzlEV2HRLR+F2hdJEiHokV72uweouFxOjX3PLFr0WvLuww1bazLQMkDVohL2OvMmgOQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877459; c=relaxed/simple;
	bh=5cOdP5FMg4EYyFbsR7DhO94Y2RMpvhTr8apUvQhY6Bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=he7G3iz/CgE+63mIS3m+k6KbZEg0IQ1agDO8cOUlsdkW9OYGqoVM+1wBHoqL9FDubpjK+Wq6qlil4etp/JQSppQicijvnd6denCS6HlRp8vNo4RdkLn9XC4XDdYOzbZUWSfmEsoQTFqCB/rQeiHSZ0WbqPjlzpI1Qr9YAaofXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu4VbXWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE269C4CEE9;
	Thu, 13 Mar 2025 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741877458;
	bh=5cOdP5FMg4EYyFbsR7DhO94Y2RMpvhTr8apUvQhY6Bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zu4VbXWKfSOkBCZdqZjYEXuYSQK8cFqNIlHoMjlw+q2XKbq672926XGzzaDktWjQf
	 zzQ/msZkAsrMJtLZtCh5cpSuIR/GPIENErsNgL+2MaCZARrWhGboGfKN77S+foXcSL
	 mPshGf4sWEDkaa5AgFWOgT9EncMZUDXadWt3uaa7pqkLfMhvZWUAVlTdUqoZr9XQZd
	 DdLDsrTs+QwOV2QhBes2bZihWMgKulrFK53EptSXS/ZUw5dr/BNmKQk9cx8xmobKrr
	 dLChq5DvIdZAaIq0+RipwiVUlkhj1ZtK9dY/sc5T38eRCZKPTgGW1rUPd/XbzCk7bB
	 a/nmgmaLAHIew==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, linux@treblig.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250306011027.257021-1-linux@treblig.org>
References: <20250306011027.257021-1-linux@treblig.org>
Subject: Re: (subset) [PATCH] mfd: ezx-pcap: Remove unused pcap_adc_sync
Message-Id: <174187745764.3698316.31150897946423757.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 14:50:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Thu, 06 Mar 2025 01:10:27 +0000, linux@treblig.org wrote:
> pcap_adc_sync() was added in 2009 by
> commit 13a09f93d2bf ("mfd: add PCAP driver")
> but has remained unused; the async version is still used.
> 
> Remove it.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: ezx-pcap: Remove unused pcap_adc_sync
      commit: 3c42bfbdf72e3004cf46bb9ec11f4a3ab4d65d9d

--
Lee Jones [李琼斯]


