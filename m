Return-Path: <linux-kernel+bounces-261056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630493B23F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CE1B230BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A9158DA7;
	Wed, 24 Jul 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1t552unR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A5157E6C;
	Wed, 24 Jul 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830079; cv=none; b=uFctJqli/IO54GC13Dg06CVj5SuR9vNBOljKiJZjfmdL8bgghNwb6REjh5q8e4H15iZ3P+ZlnXEv/dgtEv3EqfeIgTz/LN1Jv8mxaL9bi3XE76svtKC0wPeRZNwe4yFPsekLIZmo7aCH9lUVfS/pv+lILDdz7bsmtEQi9JUW6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830079; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2RCfwBZA+tQfr6yQWxM/H6bMeeFBruwCENJaMykU+S6lW/MqjVYBExYj76T4ck3qV1MtKx0ZGcqPAB/Qn8usflSa8tqfg6WuJK+jN+2qjSNspzNoapM8eg35FHgc9EcNl2zJ4bpj1jluSawy64CQR5dEQxe8LFHXU3WfwhG0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1t552unR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0F4C32781;
	Wed, 24 Jul 2024 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721830079;
	bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1t552unRzpSoq0v8oBv6r8ivO3u5h0jeh8zwQgPxdtg86q0y5DW6w43NTI/l6+L1R
	 3ejH9et/uR9lnqMXMVYHUKrBis6WxYMqrY9OemSQ6LWr1W2ZBacplTUI6xzo+z7g3V
	 nnJM3yOll+j4XMVtg5AEuHnm8KKRO5lmfcI/W2w0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.10.1
Date: Wed, 24 Jul 2024 16:07:38 +0200
Message-ID: <2024072438-mandarin-tinfoil-8a42@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024072438-spinning-unrated-6d57@gregkh>
References: <2024072438-spinning-unrated-6d57@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


