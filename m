Return-Path: <linux-kernel+bounces-199594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B528D8954
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938E9B2133E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BA913A3F2;
	Mon,  3 Jun 2024 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVEjz1iW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE7137923;
	Mon,  3 Jun 2024 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441480; cv=none; b=tv0QiDGivrhu5GLSUUlvnJqBo/u0WdUmEE9uK6NSGmWVCNcPGDlRojvh3g9UcHfJo22LY44p3XzVjJ6Arg+0m+m7boz0AedOE0BS9QIAzikNRVUic/VDRUzUVwJyXuTaomUYyJAFyCCkz+oj+elvCLjHMAOYzkRdBDNsL/BpsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441480; c=relaxed/simple;
	bh=SiJjhq+F76gd2xYIUJnRmLkcW/pcUax1GZT5innf0yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrLXKE9zFrK+JZcref+Ur9RqY+W8j2Drr6f+IxLfJQvtd6vEl57ThmYQrDrGMdKW0o+STTtLGmWLuNuh1/nQneEGOsVpFxyV8XacbJvR/RjEWf5OTDPgQNDtOaWQRMlcFyFJ3Naj6Vo1ZK6NcNSATt8WGdkF5OwpBxrWHCAN7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVEjz1iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3E2C4AF09;
	Mon,  3 Jun 2024 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717441479;
	bh=SiJjhq+F76gd2xYIUJnRmLkcW/pcUax1GZT5innf0yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVEjz1iWVYBbZpGBAolpFKdBtmgSZ54sICUew0JuIbETnve4H0k0gJUmsATrApj22
	 8bWCeCg0OiCcFi8uFYMNo/cmw9Mdg40sZ37IMLuOwKlDV10UtX24GdQtamSiblknQ7
	 N8ZkVCyqV4APP+2d/iduxIXrKn4DMTP8dQ/ahGfBmnajMRdjdlyXqtB1VaT76QmQlo
	 LSL/mPn4tlLMwEhLzA2regmdBiIcSJT8Ez7w0fwfNO/cK5YfOO+6t9It2nEp6lThez
	 e6YA2G3EYNY4dDwNQPVvzVNZo0dbgKD4Jp/qBlvlqBEzpZDV1paa2JMVpnOOEXq42d
	 VfVXoXkIukNyA==
From: SeongJae Park <sj@kernel.org>
To: yskelg@gmail.com
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jinwoo Park <pmnxis@gmail.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Documentation: cve Korean translation
Date: Mon,  3 Jun 2024 12:04:36 -0700
Message-Id: <20240603190436.222077-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603161530.80789-1-yskelg@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue,  4 Jun 2024 01:15:31 +0900 yskelg@gmail.com wrote:

> From: Yunseong Kim <yskelg@gmail.com>
> 
> This is a Documentation/process/cve korean version.
> 
> The following changes have been updated based on SeongJae Park’s feedback
> and Austin Kim’s from the last v2 and v3 patches.
> 
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>  Documentation/translations/ko_KR/index.rst    |   2 +-
>  .../translations/ko_KR/process/cve.rst        | 119 +++++++++---------
>  2 files changed, 61 insertions(+), 60 deletions(-)
> 
> diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/translations/ko_KR/index.rst
> index 4add6b2fe1f2..f38f0ce19a1e 100644
> --- a/Documentation/translations/ko_KR/index.rst
> +++ b/Documentation/translations/ko_KR/index.rst
> @@ -12,7 +12,7 @@
>     :maxdepth: 1
>  
>     howto
> -

I don't think you need to delete the above line.

> +   process/cve
>  
>  리눅스 커널 메모리 배리어
>  -------------------------
> diff --git a/Documentation/translations/ko_KR/process/cve.rst b/Documentation/translations/ko_KR/process/cve.rst
> index 94610c177f17..5a84d0d4266f 100644
> --- a/Documentation/translations/ko_KR/process/cve.rst
> +++ b/Documentation/translations/ko_KR/process/cve.rst
> @@ -1,7 +1,9 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -:Original: Documentation/process/cve.rst
> -:Translator: Yunseong Kim <yskelg@gmail.com>
> +:원문: Documentation/process/cve.rst
> +:역자: 김윤성 <yskelg@gmail.com>
> +:감수: 박진우 <pmnxis@gmail.com>, 박성재 <sj@kernel.org>,

Thank you for adding me.  However, please don't add me here unless I ask you
to.


Thanks,
SJ

[...]

