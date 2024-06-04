Return-Path: <linux-kernel+bounces-200957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5608FB75C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602F81F2862A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D763146598;
	Tue,  4 Jun 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlTqRI1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745C38396;
	Tue,  4 Jun 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514997; cv=none; b=jUBxuSmt7yD9WwieLg0iBkNv0Cwm/ZO1Wo6wEPowX3GBCCwtRMxx02PFfsZO+4+9kMf0bXgiGftWOYdb5C8uFW1UlQjak4PPZD87abKg0YQU8hzCnNHweAfxXURNmg1E0AdPm/ZMaxDxYEE3mGnogspiHprsarF+kqxC86aFrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514997; c=relaxed/simple;
	bh=C14isIc+P1iK/ldU8nKQNQ5GsUEH1CTcFuGOrpxQgw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGLK0+VNlzkm+kVozawDFZ+BmlsYsOLLhI+JLTckaCuNNgKr51QaGgDqVP7/1BHw7BfCJ/7tCo6e034Kc+93x1gyAUlgmUlZBh5B7vQEmZKkVbY5jcwIJWBofmTh00wssCTLsi7qz3t3GrOsYCD08fv7xGufmb1HmLgAFgUMWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlTqRI1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83031C2BBFC;
	Tue,  4 Jun 2024 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514997;
	bh=C14isIc+P1iK/ldU8nKQNQ5GsUEH1CTcFuGOrpxQgw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlTqRI1LNEJ6rKXTKRWw7KUeeyl/GM+DZ3olfHmt2SkLTXWRn/aLmnJefLwdA2voo
	 eBhjvMCMKefDeWLlWOKZ2HJr3H7EC2MPF9d6KnM2lnVuLGS87W4jpS5dQUK+ktjaRk
	 H6l7a2z64tPEfYJEmaMERg5/TeSjxrWmODhrqixUVN5k4sJo4SKLqlptSqGkogmFAs
	 8blKMwWPhWWWlZyaYvLWtLlcLL6sWnY07E4oZUxKvu1gzHbkssoC4nrK0tzgbyMKTM
	 lBzoZXoamn45w0x/lR6Trik4AThLJ0a688DBG0xqJfP39lXvnsuBJZNVSjFsfUeuXY
	 fX2sou7dzV/Hw==
From: William Breathitt Gray <wbg@kernel.org>
To: Patrick Havelange <patrick.havelange@essensium.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] counter: ftm-quaddec: add missing MODULE_DESCRIPTION() macro
Date: Wed,  5 Jun 2024 00:29:25 +0900
Message-ID: <171751489612.794006.17943846980351481989.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240602-md-ftm-quaddec-v1-1-1bbdf705ad31@quicinc.com>
References: <20240602-md-ftm-quaddec-v1-1-1bbdf705ad31@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=472; i=wbg@kernel.org; h=from:subject:message-id; bh=82o0fVij14ivELuN2t+845WpXw79WOc8i9daX3vtnEs=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDGnxRrM3zWdz4052V5X7oOln8upX2KrY/gJlj6ebtq4+/ ffRhhMJHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBE5nQz/A888My93VKeiS3i DIvXwzmHFszOF13wn/nOQsXZbvX8jyIZ/tewXU7Y6DfLdLK/EbOJ+vX06U+1k8JW6T1Ut/vp41u lwwQA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Sun, 02 Jun 2024 15:05:20 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/counter/ftm-quaddec.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] counter: ftm-quaddec: add missing MODULE_DESCRIPTION() macro
      commit: b84dba784fcb44d142bcc49effbb27244fe782cc

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

